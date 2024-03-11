# frozen_string_literal: true

class AndroidApk
  module Aapt2
    class DumpBadging
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
      class Result
        attr_reader :label, :default_icon_path, :test_only, :package_name, :version_code, :version_name, :min_sdk_version, :target_sdk_version, :icons, :labels

        def initialize(variables)
          # application info
          @label = variables["application-label"]

          @default_icon_path = variables["application"]["icon"]
          @test_only = variables.key?("testOnly='-1'")

          # package

          @package_name = variables["package"]["name"]
          @version_code = variables["package"]["versionCode"]
          @version_name = variables["package"]["versionName"] || ""

          # platforms
          @min_sdk_version = variables["sdkVersion"]
          @target_sdk_version = variables["targetSdkVersion"]

          # icons and labels
          @icons = {} # old
          @labels = {}

          variables.each_key do |k|
            if (m = k.match(/\Aapplication-icon-(\d+)\z/))
              @icons[m[1].to_i] = variables[k]
            elsif (m = k.match(/\Aapplication-label-(\S+)\z/))
              @labels[m[1]] = variables[k]
            end
          end
        end

        alias test_only? test_only
      end

      def self.dump_badging(apk_filepath:)
        stdout, stderr, status = Open3.capture3("aapt2", "dump", "badging", "--include-meta-data", apk_filepath)
        stdout if status.success?

        if status.success?
          stdout
        else
          if stderr.index(/ERROR:?\s/) # : is never required because it's mixed.
            # *normally* failed. The output of aapt2 dump is helpful.
            # ref: https://cs.android.com/android/platform/superproject/+/master:frameworks/base/tools/aapt/Command.cpp;l=860?q=%22dump%20failed%22%20aapt
            raise UnacceptableApkError, "This apk file cannot be analyzed using 'aapt2 dump badging --include-meta-data'. stdout = #{stdout}, stderr = #{stderr}"
          else
            # unexpectedly failed. This may happen due to the running environment.
            raise UnacceptableApkError, "'aapt2 dump badging --include-meta-data' failed due to an unexpected error."
          end
        end
      end

      # @param apk_filepath [String] a path to apk_filepath
      def initialize(apk_filepath:)
        @apk_filepath = apk_filepath
        @dump_results = self.class.dump_badging(apk_filepath: apk_filepath)&.scrub&.split("\n")
      end

      # Parse output of aapt2 command to Hash format
      #
      # @return [::AndroidApk::Aapt2::DumpBadging::Result]
      def parse
        vars = {}
        results = @dump_results.dup
        results.each do |line|
          key, value = parse_line(line)
          next if key.nil?

          if vars.key?(key)
            reject_illegal_duplicated_key!(key)

            if vars[key].kind_of?(Hash) and value.kind_of?(Hash)
              vars[key].merge(value)
            else
              vars[key] = [vars[key]] unless vars[key].kind_of?(Array)
              if value.kind_of?(Array)
                vars[key].concat(value)
              else
                vars[key].push(value)
              end
            end
          else
            vars[key] = if value.nil? || value.kind_of?(Hash)
                          value
                        else
                          value.length > 1 ? value : value[0]
                        end
          end
        end

        Result.new(vars)
      end

      # workaround for https://code.google.com/p/android/issues/detail?id=160847
      private def parse_values_workaround(str)
        return nil if str.nil?

        str.scan(/^'(.+)'$/).map { |v| v[0].gsub("\\'", "'") }
      end

      # Parse values of aapt output
      #
      # @param [String, nil] str a values string of aapt output.
      # @return [Array, Hash, nil] return nil if (see str) is nil. Otherwise the parsed array will be returned.
      private def parse_values(str)
        return nil if str.nil?

        if str.index("='")
          # key-value hash
          vars = str.scan(/(\S+)='((?:\\'|[^'])*)'/).to_h
          vars.each_value { |v| v.gsub("\\'", "'") }
        else
          # values array
          vars = str.scan(/'((?:\\'|[^'])*)'/).map { |v| v[0].gsub("\\'", "'") }
        end
        return vars
      end

      # Parse output of a line of aapt command like `key: values`
      #
      # @param [String, nil] line a line of aapt command.
      # @return [[String, Hash], nil] return nil if (see line) is nil. Otherwise the parsed hash will be returned.
      private def parse_line(line)
        return nil if line.nil?

        info = line.split(":", 2)
        values =
          if info[0].start_with?("application-label")
            parse_values_workaround info[1]
          else
            parse_values info[1]
          end
        return info[0], values
      end

      # @param [String] key a key of AndroidManifest.xml
      # @raise [AndroidManifestValidateError] if a key is found in (see NOT_ALLOW_DUPLICATE_TAG_NAMES)
      private def reject_illegal_duplicated_key!(key)
        raise AndroidManifestValidateError, key if NOT_ALLOW_DUPLICATE_TAG_NAMES.include?(key)
      end
    end
  end
end
