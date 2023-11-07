# frozen_string_literal: true

class AndroidApk
  module SignatureVerifier
    # [0]: entire, [1]: digest
    SIGNER_SIGNATURE_REGEX = /\ASigner\s.+(?:MD5|SHA-?1|SHA-?256)\sdigest:\s([0-9a-zA-Z]{32,})\s*\z/i.freeze

    # [min_sdk(inclusive), max_sdk(inclusive)]
    SCHEME_CASE_INPUTS = [
      [
        9,
        17
      ],
      # SHA256 with RSA is supported since API 18 but still v1 scheme
      [
        18,
        23
      ],
      # v2 scheme has been introduced since API 24
      # v3 and v3.1 are extended from v2, so we don't have to treat v3 and v3.1 specially.
      # v3 has been introduced since API 28, v3.1 is available since 33 by the way.
      [
        24,
        2_147_483_647
      ]
    ].freeze

    # @param [String] filepath to an apk file
    # @param [Integer, String] min_sdk_version of an apk
    # @return [Array<Hash<String => Any>>] sdk-ranged certificate information array order by min_sdk_version asc
    module_function def verify(filepath:, min_sdk_version:)
      min_sdk_version = min_sdk_version.to_i

      SCHEME_CASE_INPUTS.each_with_object([]) do |versions, constraints|
        min_sdk, max_sdk, = versions
        next unless min_sdk_version <= max_sdk

        signer_hunks = ::AndroidApk::ApkSigner.print_certs(
          filepath: filepath,
          min_sdk_version: [min_sdk, min_sdk_version].max,
          max_sdk_version: max_sdk
        )

        next if signer_hunks.empty?

        signer_hunks.each do |sdk_versions, signer_lines|
          # { "sha1" => ..., ... }
          signature = signer_lines.each_with_object(
            {
              "min_sdk_version" => [sdk_versions[0].to_i, min_sdk_version].max,
              "max_sdk_version" => sdk_versions[1].to_i
            }
          ) do |line, acc|
            unless (m = line.match(SIGNER_SIGNATURE_REGEX)).nil?
              acc.merge!({ ::AndroidApk::SignatureDigest.judge(digest: m[1]) => m[1] })
            end
          end

          constraints.push(signature)
        end
      end
    end
  end
end
