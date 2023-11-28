# frozen_string_literal: true

class AndroidApk
  module SignatureVerifier
    # SHA256 with RSA is supported since API 18 but still v1 scheme
    V1_SHA256_RSA_SDK_INT = 18
    V2_SCHEME_SDK_INT = 24
    V3_SCHEME_SDK_INT = 28
    V3_1_SCHEME_SDK_INT = 33
    DEFAULT_MAX_SDK_INT = 2_147_483_647

    # Actually, this should be 30 by spec but apksigner detect only if max sdk is 33 or higher ;(
    V2_REQUIRED_SDK_INT_FOR_APKSIGNER = 33

    # [0]: entire, [1]: digest
    SIGNER_SIGNATURE_REGEX = /\ASigner\s.+(?:MD5|SHA-?1|SHA-?256)\sdigest:\s([0-9a-zA-Z]{32,})\s*\z/i.freeze

    # [min_sdk(inclusive), max_sdk(inclusive)]
    SCHEME_CASE_INPUTS = [
      [
        9,
        V1_SHA256_RSA_SDK_INT - 1
      ],
      # Only this range can detect fingerprints of v1 scheme correctly including sha256 w/ rsa
      [
        V1_SHA256_RSA_SDK_INT,
        V2_SCHEME_SDK_INT - 1
      ],
      # Only this range can detect fingerprints of v3 scheme correctly for devices that do not support v3 scheme
      [
        V2_SCHEME_SDK_INT,
        V3_SCHEME_SDK_INT - 1
      ],
      # This range can return fingerprints v2 or v2+ correctly
      [
        V3_SCHEME_SDK_INT,
        DEFAULT_MAX_SDK_INT
      ]
    ].freeze

    # @param [String] filepath to an apk file
    # @param [Integer, String] min_sdk_version of an apk
    # @return [Array<Hash<String => Any>>] sdk-ranged certificate information array order by min_sdk_version asc
    module_function def verify(filepath:, min_sdk_version:)
      min_sdk_version = min_sdk_version.to_i

      skip_v2_requirement_check = false

      collected_fingerprints = SCHEME_CASE_INPUTS.each_with_object([]) do |versions, fingerprints|
        min_sdk, max_sdk, = versions
        next unless min_sdk_version <= max_sdk

        min_sdk_for_verification = [min_sdk, min_sdk_version].max

        if !skip_v2_requirement_check && min_sdk_for_verification >= V2_SCHEME_SDK_INT && max_sdk < V2_REQUIRED_SDK_INT_FOR_APKSIGNER
          skip_v2_requirement_check = true

          # If this apk has no v2 or v2+ schemes, this verification must fail.
          # The results of this verification cannot be used because of v3 scheme's flaw...
          invalid_v2_or_higher = ::AndroidApk::ApkSigner.print_certs(
            filepath: filepath,
            min_sdk_version: min_sdk_for_verification,
            max_sdk_version: DEFAULT_MAX_SDK_INT
          ).empty?

          break fingerprints if invalid_v2_or_higher
        end

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

          fingerprints.push(signature)
        end
      end

      merge_fingerprints(fingerprints: collected_fingerprints)
    end

    module_function def merge_fingerprints(fingerprints:)
      merged_fingerprints = fingerprints.sort_by { |f| f.fetch("min_sdk_version") }.each_with_object([]) do |fingerprint, acc|
        # SKip unsigned span
        next if fingerprint[::AndroidApk::SignatureDigest::SHA256].nil?

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
