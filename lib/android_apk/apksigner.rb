# frozen_string_literal: true

class AndroidApk
  module ApkSigner
    # [0]: entire, [1]: \d+, [2]: \d+
    TARGET_SDK_PART_REGEX = /\(minSdkVersion=(\d+),\s*maxSdkVersion=(\d+)\)/i.freeze

    # @param filepath [String] a file path of an apk file
    # @return [Array<Array<String>>] a list of lines for each signer
    module_function def lineage(filepath:)
      args = [
        "apksigner",
        "lineage",
        "--in",
        filepath,
        "--print-certs"
      ]

      stdout, _, exit_status = Open3.capture3(*args)

      if exit_status.success?
        split_linage_signer_hunks(stdout: stdout)
      else
        []
      end
    end

    # @param filepath [String] a file path of an apk file
    # @param min_sdk_version [String, Integer] min sdk version to verify
    # @param max_sdk_version [String, Integer] max sdk version to verify
    # @return [Hash<String => Array<String>>] a map of lines for each target sdk version range
    module_function def print_certs(filepath:, min_sdk_version:, max_sdk_version:)
      # Don't add -v because it will print pub keys too.
      args = [
        "apksigner",
        "verify",
        "--min-sdk-version",
        min_sdk_version.to_s,
        "--max-sdk-version",
        max_sdk_version.to_s,
        "--print-certs",
        filepath
      ]
      stdout, stderr, exit_status = Open3.capture3(*args)

      if exit_status.success?
        split_verify_signer_hunks(stdout: stdout, min_sdk_version: min_sdk_version, max_sdk_version: max_sdk_version)
      else
        return {} if stderr.downcase.include?("does not verify")

        raise AndroidApk::ApkSignerExecutionError, "this file is a malformed apk"
      end
    end

    module_function def split_linage_signer_hunks(stdout:)
      signers = []
      signer_index = 0

      stdout.split("\n").each do |line|
        unless (signer_number = line[/\ASigner\s#(\d+)\s/, 1]&.to_i).nil?
          signer_index = signer_number - 1
        end

        signers[signer_index] ||= []

        if line.start_with?("Has") || !line.include?("DN: CN")
          signers[signer_index].push(line)
        end
      end

      signers.compact
    end

    module_function def split_verify_signer_hunks(stdout:, min_sdk_version:, max_sdk_version:)
      signers = {}

      lines = stdout.split("\n").reject { |line| line.include?("WARNING") || line.include?("DN: CN") }

      if lines[0].include?("minSdkVersion=")
        lines.each do |line|
          next if (m = line.match(TARGET_SDK_PART_REGEX)).nil?

          sdk_versions = [m[1], m[2]]
          signers[sdk_versions] ||= []
          signers[sdk_versions].push(line)
        end
      else
        # TODO: support multiple signers
        lines.each do |line|
          if !(signer_number = line[/\ASigner\s#(\d+)\s/, 1]&.to_i).nil? && (signer_number >= 2)
            raise "Signer ##{signer_number} is found but it has not been supported yet"
          end
        end

        sdk_versions = [min_sdk_version.to_s, max_sdk_version.to_s]

        signers[sdk_versions] = lines
      end

      signers.compact
    end
  end
end
