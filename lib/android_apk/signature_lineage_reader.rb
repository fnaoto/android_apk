# frozen_string_literal: true

class AndroidApk
  module SignatureLineageReader
    # [0]: entire, [1]: digest
    SIGNER_SIGNATURE_REGEX = /\ASigner\s.+(?:MD5|SHA-?1|SHA-?256)\sdigest:\s([0-9a-zA-Z]{32,})\s*\z/i.freeze
    # [0]: entire, [1]: capability name, [2]: true or not
    CAPABILITY_SIGNATURE_REGEX = /\AHas\s(.+)\scapability\s*:\s*(true|false)\s*\z/i.freeze

    # @param [String] filepath to an apk file
    # @return [Array<Hash<String => String | Boolean>>] parsed lineage results
    module_function def read(filepath:)
      signer_hunks = ::AndroidApk::ApkSigner.lineage(filepath: filepath)
      signer_hunks.map do |signer_lines|
        # { "sha1" => ..., "rollback" => true|false, ... }
        signer_lines.each_with_object({}) do |line, acc|
          if !(m = line.match(SIGNER_SIGNATURE_REGEX)).nil?
            acc.merge!({ ::AndroidApk::SignatureDigest.judge(digest: m[1]) => m[1] })
          elsif !(m = line.match(CAPABILITY_SIGNATURE_REGEX)).nil?
            acc.merge!({ m[1].downcase => (m[2] == "true") })
          end
        end
      end
    end
  end
end
