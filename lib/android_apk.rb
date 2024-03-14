# frozen_string_literal: true

require "fileutils"
require "forwardable"
require "open3"
require "shellwords"
require "tmpdir"
require "zip"

require_relative "android_apk/apksigner"
require_relative "android_apk/app_icon"
require_relative "android_apk/app_signature"
require_relative "android_apk/error"
require_relative "android_apk/resource_finder"
require_relative "android_apk/signature_digest"
require_relative "android_apk/signature_lineage_reader"
require_relative "android_apk/signature_verifier"
require_relative "android_apk/xmltree"
require_relative "android_apk/aapt2/dump_badging"
require_relative "android_apk/aapt2/dump_resources"

# @!attribute [r] aapt2_badging_result
#   @return [AndroidApk::Aapt2::DumpBadging::Result]
# @!attribute [r] label
#   @return [String, NilClass] Return a value which is defined in AndroidManifest.xml. Could be nil.
# @!attribute [r] default_icon_path
#   @return [String] Return a relative path of this apk's icon. This is the real filepath in the apk but not resource-friendly path.
# @!attribute [r] test_only
#   @return [Boolean] Check whether or not this apk is a test mode. Return true if an apk is a test apk
# @!attribute [r] package_name
#   @return [String] an application's package name which is defined in AndroidManifest
# @!attribute [r] version_code
#   @return [String] an application's version code which is defined in AndroidManifest
# @!attribute [r] version_name
#   @return [String] an application's version name which is defined in AndroidManifest
# @!attribute [r] min_sdk_version
#   @return [String, NilClass] an application's min sdk version. The format is an integer string which is defined in AndroidManifest.xml. Legacy apk may return nil.
# @!attribute [r] target_sdk_version
#   @return [String, NilClass] an application's target sdk version. The format is an integer string which is defined in AndroidManifest.xml. Legacy apk may return nil.
# @!attribute [r] labels
#   @return [Hash] an application's labels a.k.a application name in available resources.
# @!attribute [r] icons
#   @return [Hash] an application's relative icon paths grouped by densities
#   @deprecated no longer used
# @!attribute [r] icon_path_hash
#   @return [Hash] Application icon paths for all densities that are human readable names. This value may contains anyapi-v<api_version>.
# @!attribute [r] app_signature
#   @return [AndroidApk::AppSignature] An object contains lineages and certificate fingerprints
# @!attribute [r] meta_data
#   @return [Hash] Named hash of meta-data tags in AndroidManifest.xml. Return an empty if none is found.
class AndroidApk
  FALLBACK_DPI = 65_534
  ADAPTIVE_ICON_SDK = 26

  DEFAULT_RESOURCE_CONFIG = "(default)" # very special config

  class << self
    attr_writer :logger

    def logger
      @logger ||= Logger.new($stdout)
    end
  end

  DPI_TO_NAME_MAP = {
    120 => "ldpi",
    160 => "mdpi",
    240 => "hdpi",
    320 => "xhdpi",
    480 => "xxhdpi",
    640 => "xxxhdpi",
  }.freeze

  SUPPORTED_DPIS = DPI_TO_NAME_MAP.keys.freeze
  SUPPORTED_DPI_NAMES = DPI_TO_NAME_MAP.values.freeze

  module Reason
    # @deprecated this is the same to Unsigned
    UNVERIFIED = :unverified
    TEST_ONLY = :test_only
    UNSIGNED = :unsigned
  end

  extend Forwardable

  attr_reader :aapt2_badging_result, :icon_path_hash, :app_signature

  delegate %i(label default_icon_path test_only test_only? package_name version_code version_name min_sdk_version target_sdk_version icons labels meta_data) => :@aapt2_badging_result

  alias icon default_icon_path
  alias sdk_version min_sdk_version

  # Do analyze the given apk file. Analyzed apk does not mean *valid*.
  #
  # @param [String] filepath a filepath of an apk to be analyzed
  # @return [AndroidApk] An instance of AndroidApk will be returned if no problem exists while analyzing.
  # @raise [AndroidApk::ApkFileNotFoundError] if the filepath doesn't exist
  # @raise [AndroidApk::Aapt2Error] if the apk file is not acceptable by commands like aapt
  # @raise [AndroidApk::InvalidApkError] if the apk contains invalid AndroidManifest.xml but only when we can identify why it's invalid.
  def self.analyze(filepath)
    AndroidApk.new(
      filepath: filepath
    )
  end

  def initialize(
    filepath:
  )
    raise ApkFileNotFoundError, "an apk file is required to analyze." unless File.exist?(filepath)

    @filepath = filepath
    @aapt2_badging_result = Aapt2::DumpBadging.new(apk_filepath: filepath).parse

    # It seems the resources in the aapt's output doesn't mean that it's available in resource.arsc
    icons_in_arsc = ::AndroidApk::ResourceFinder.decode_resource_table(
      apk_filepath: filepath,
      default_icon_path: default_icon_path
    )

    @icon_path_hash = icons.dup.transform_keys do |dpi|
      DPI_TO_NAME_MAP[dpi] || DEFAULT_RESOURCE_CONFIG
    end.merge(icons_in_arsc)

    @app_signature = AppSignature.parse(filepath: filepath, min_sdk_version: min_sdk_version)
  end

  # @return [Array<AndroidApk::AppIcon>]
  def app_icons
    # [[highest dpi (or prior-level resolution), path], ...]
    sorted_paths = icon_path_hash.transform_keys do |name|
      case name
      when /anydpi-v(\d+)/
        8_000 + Regexp.last_match(1).to_i # Prioritized
      when "anydpi"
        7_000 # Fallback of anydpi-v\d+
      when DEFAULT_RESOURCE_CONFIG
        100 # Weakest
      else # Intermediate
        # We assume Google never release lower density than ldpi
        DPI_TO_NAME_MAP.key(name) || DPI_TO_NAME_MAP.keys.max
      end
    end.sort.reverse

    sorted_paths.map { |dpi, path| ::AndroidApk::AppIcon.new(apk_filepath: @filepath, dpi: dpi, resource_path: path) }
  end

  # @deprecated no longer used
  # Get an application icon file of this apk file.
  #
  # @param [Integer] dpi one of (see SUPPORTED_DPIS)
  # @param [Boolean] want_png request a png icon expressly
  # @return [File, nil] an application icon file object in temp dir
  def icon_file(dpi = nil, want_png = false) # rubocop:disable Style/OptionalBooleanParameter
    icon = dpi ? self.icons[dpi.to_i] : self.icon
    return nil if icon.nil? || icon.empty?

    # Unfroze just in case
    icon = +icon
    dpis = dpi_str(dpi)

    # neat adaptive icon apk
    if want_png && icon.end_with?(".xml")
      icon.gsub!(%r{res/(drawable|mipmap)-anydpi-(?:v\d+)/([^/]+)\.xml}, "res/\\1-#{dpis}-v4/\\2.png")
    end

    # 1st fallback is for WEIRD adaptive icon apk e.g. Cordiva generates such apks
    if want_png && icon.end_with?(".xml")
      icon.gsub!(%r{res/(drawable|mipmap)-.+?dpi-(?:v\d+)/([^/]+)\.xml}, "res/\\1-#{dpis}-v4/\\2.png")
    end

    # 2nd fallback is for vector drawable icon apk. Use a png file which is manually resolved
    if want_png && icon.end_with?(".xml")
      icon.gsub!(%r{res/(drawable|mipmap)/([^/]+)\.xml}, "res/\\1-#{dpis}-v4/\\2.png")
    end

    # we cannot prepare for any fallbacks but don't return nil for now to keep the behavior

    Dir.mktmpdir do |dir|
      output_to = File.join(dir, icon)

      FileUtils.mkdir_p(File.dirname(output_to))

      Zip::File.open(@filepath) do |zip_file|
        entry = zip_file.find_entry(icon) or return nil

        File.binwrite(output_to, zip_file.read(entry))
      end

      return nil unless File.exist?(output_to)

      return File.new(output_to, "r")
    end
  end

  # @deprecated no longer used
  def available_png_icon
    png_path = DPI_TO_NAME_MAP.keys.sort { |l, r| r - l }
      .lazy
      .map { |dpi| icon_path_hash[DPI_TO_NAME_MAP[dpi]] }
      .find { |path| path&.end_with?(".png") }

    return if png_path.nil?

    Dir.mktmpdir do |dir|
      output_to = File.join(dir, png_path)
      FileUtils.mkdir_p(File.dirname(output_to))

      Zip::File.open(@filepath) do |zip_file|
        entry = zip_file.find_entry(png_path)

        next if entry.nil?

        File.binwrite(output_to, zip_file.read(entry))
      end

      break unless File.exist?(output_to)

      return File.new(output_to, "r")
    end
  end

  # dpi to android drawable resource config name
  #
  # @param [Integer] dpi one of (see SUPPORTED_DPIS)
  # @return [String] (see SUPPORTED_DPIS). Return "xxxhdpi" if (see dpi) is not in (see SUPPORTED_DPIS)
  def dpi_str(dpi)
    DPI_TO_NAME_MAP[dpi.to_i] || "xxxhdpi"
  end

  def adaptive_icon_density
    min_sdk_version.to_i >= ADAPTIVE_ICON_SDK ? "anydpi" : "anydpi-v26"
  end

  # @return [Boolean] returns true if the default app icon is a xml, otherwise false.
  def xml_icon?
    !icon_xmltree.nil? && (icon_xmltree.vector_drawable? || icon_xmltree.adaptive_icon?)
  end

  # Check whether or not this apk's icon is an adaptive icon
  # @return [Boolean] Return true if this apk has an *correct* adaptive icon, otherwise false.
  def adaptive_icon?
    return @adaptive_icon if defined?(@adaptive_icon)

    @adaptive_icon = nil
    @adaptive_icon = sdk_version.to_i >= ADAPTIVE_ICON_SDK ? icon_xmltree&.adaptive_icon? : backward_compatible_adaptive_icon?
  end

  # Check whether or not this apk's icon is a backward-compatible adaptive icon for lower sdk
  # @return [Boolean] Return true if this apk has an adaptive icon and a fallback icon, otherwise false.
  def backward_compatible_adaptive_icon?
    return @backward_compatible_adaptive_icon if defined?(@backward_compatible_adaptive_icon)

    @backward_compatible_adaptive_icon = nil
    # at least one png icon is required if min sdk version doesn't support adaptive icon
    @backward_compatible_adaptive_icon = icon_xmltree&.adaptive_icon? && SUPPORTED_DPI_NAMES.any? { |d| icon_path_hash[d]&.end_with?(".png") }
  end

  # deprecations

  # The trusted signature lineage. The first element is the same to the signing signature of the apk file.
  # @return [Array<String>] empty if it's unsigned.
  def trusted_signature_lineage
    return [] if app_signature.unsigned?

    if app_signature.lineages.empty?
      [signature]
    else
      app_signature.lineages.map { |l| l[SignatureDigest::SHA1] }.reverse
    end
  end

  # The SHA-1 signature of this apk
  # @deprecated single signature is not applicable since scheme v3
  # @return [String, nil] Return nil if cannot extract sha1 hash, otherwise the value will be returned.
  def signature
    v = app_signature.get_fingerprint(sdk_version: target_sdk_version.to_i)
    v && v[SignatureDigest::SHA1]
  end

  # Check whether or not this apk is verified
  # @deprecated single signature is not applicable since scheme v3
  # @return [Boolean] Return true if this apk is verified, otherwise false.
  def verified
    !signature.nil?
  end

  alias verified? verified

  # Whether or not this apk is signed but this depends on (see signature)
  # @deprecated single signature is not applicable since scheme v3
  # @return [Boolean, nil] this apk is signed if true, otherwise not signed.
  def signed?
    signature != nil
  end

  # @deprecated this value contains true-negative since scheme v3.1
  # @return [Boolean] Return true if this apk is installable, otherwise false.
  def installable?
    uninstallable_reasons.empty?
  end

  # @deprecated this value contains true-negative since scheme v3.1
  # @return [Array<Symbol>] Return non-empty symbol array which contain reasons, otherwise an empty array.
  def uninstallable_reasons
    reasons = []
    reasons << Reason::UNVERIFIED unless verified?
    reasons << Reason::UNSIGNED unless signed?
    reasons << Reason::TEST_ONLY if test_only?
    reasons
  end

  # end: deprecations

  # @return [AndroidApk::Xmltree, NilClass]
  private def icon_xmltree
    return @icon_xmltree if defined?(@icon_xmltree)

    @icon_xmltree = nil
    @icon_xmltree = Xmltree.read(apk_filepath: @filepath, xml_filepath: icon) if icon.end_with?(".xml")
  end
end
