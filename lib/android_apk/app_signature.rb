# frozen_string_literal: true

class AndroidApk
  # @!attribute [r] fingerprints
  #   @return [Array<Hash<String => Any>>]
  # @!attribute [r] lineages
  #   @return [Array<Hash<String => Any>>]
  class AppSignature
    class << self
      # @param [String] filepath to an apk file
      # @param [Integer, String] min_sdk_version
      # @return [AppSignature] a new signature
      def parse(filepath:, min_sdk_version:)
        lineages = ::AndroidApk::SignatureLineageReader.read(filepath: filepath)
        fingerprints = ::AndroidApk::SignatureVerifier.verify(filepath: filepath, min_sdk_version: min_sdk_version)

        AppSignature.new(
          lineages: lineages,
          fingerprints: fingerprints
        )
      end
    end

    attr_reader :fingerprints, :lineages

    def initialize(lineages:, fingerprints:)
      @fingerprints = merge_fingerprints(fingerprints: fingerprints).freeze
      @lineages = @fingerprints.empty? ? [].freeze : lineages.freeze # drop if unsigned
      raise "lineages must be an empty or a list of 2 or more elements" if @lineages.size == 1
    end

    # @param [Integer] sdk_version
    # @return [Hash<String => Any>, nil]
    def get_fingerprint(sdk_version:)
      # Ruby doesn't have TreeMap...
      @fingerprints.find do |cert|
        cert.fetch("min_sdk_version") <= sdk_version && sdk_version <= cert.fetch("max_sdk_version")
      end
    end

    def unsigned?
      @fingerprints.empty?
    end

    def rotated?
      !@lineages.empty?
    end

    private def merge_fingerprints(fingerprints:)
      merged_fingerprints = fingerprints.each_with_object([]) do |fingerprint, acc|
        if !(last_entry = acc.last).nil? && (last_entry.fetch(::AndroidApk::SignatureDigest::SHA256) == fingerprint.fetch(::AndroidApk::SignatureDigest::SHA256))
          last_max_sdk_version = last_entry.fetch("max_sdk_version")
          min_sdk_version = fingerprint.fetch("min_sdk_version")

          if last_max_sdk_version + 1 == min_sdk_version || min_sdk_version <= last_max_sdk_version
            last_entry["max_sdk_version"] = fingerprint["max_sdk_version"]
            next
          end
        end

        acc.push(fingerprint)
      end

      return [] if merged_fingerprints.size == 1 && merged_fingerprints[0].fetch(::AndroidApk::SignatureDigest::SHA256).nil?

      merged_fingerprints
    end
  end
end
