# frozen_string_literal: true

class AndroidApk
  module SignatureVerifier
    extend self

    # [0]: entire, [1]: digest
    SIGNER_SIGNATURE_REGEX = /\ASigner\s.+(?:MD5|SHA-?1|SHA-?256)\sdigest:\s([0-9a-zA-Z]{32,})\s*\z/i.freeze

    SCHEME_CASE_INPUTS = [
      # [min_sdk(inclusive), max_sdk(inclusive)]

      # Legacy v1 scheme
      [
        1,
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
    ]

    def verify(filepath:, min_sdk_version:)
      min_sdk_version = min_sdk_version.to_i

      SCHEME_CASE_INPUTS.each_with_object([]) do |versions, constraints|
        min_sdk, max_sdk, = versions
        min_sdk_version_for_verification = [min_sdk, min_sdk_version].max

        if min_sdk_version <= max_sdk
          signer_hunks = ::AndroidApk::ApkSigner.verify(
            filepath: filepath,
            min_sdk_version: min_sdk_version_for_verification,
            max_sdk_version: max_sdk
          )

          if signer_hunks.empty?
            constraints.push(
              {
                "min_sdk_version" => min_sdk_version_for_verification,
                "max_sdk_version" => max_sdk,
                ::AndroidApk::SignatureDigest::MD5 => nil,
                ::AndroidApk::SignatureDigest::SHA1 => nil,
                ::AndroidApk::SignatureDigest::SHA256 => nil
              }
            )
          else
            signer_hunks.each do |sdk_versions, signer_lines|
              # { "sha1" => ..., ... }
              signature = signer_lines.each_with_object(
                {
                  "min_sdk_version" => sdk_versions[0].to_i,
                  "max_sdk_version" => sdk_versions[1].to_i
                }
              ) do |line, acc|
                if (m = line.match(SIGNER_SIGNATURE_REGEX)) != nil
                  acc.merge!({ ::AndroidApk::SignatureDigest.judge(digest: m[1]) => m[1] })
                else
                  # unknown
                end
              end

              constraints.push(signature)
            end
          end
        end
      end
    end
  end
end
