# frozen_string_literal: true

class AndroidApk
  module SignatureVerifier
    SHA1_CAPTURE_REGEX = /(?:[0-9a-zA-Z]{2}:?){20}/.freeze

    class << self
      # @param filepath [String] an apk filepath (must exist)
      # @param target_sdk_version [Integer, String] its target sdk version
      # @return [Array<String>] a signing signature of an apk file with its lineage. Returns an empty array if it's unsigned.
      def verify(filepath:, target_sdk_version:)
        # Use target_sdk_version as min sdk version!
        # Because some of apks are signed by only v2 scheme even though they have 23 and lower min sdk version
        #
        # Don't add -v because it will print pub keys too.
        args = [
          "apksigner",
          "verify",
          "--min-sdk-version",
          target_sdk_version.to_s,
          "--print-certs",
          filepath
        ]
        stdout, stderr, exit_status = Open3.capture3(*args)

        unless exit_status.success?
          return [] if stderr.downcase.include?("does not verify")

          raise AndroidApk::ApkSignerExecutionError, "this file is a malformed apk"
        end

        # The output of the single signing contains Signer #1 but multiple signing a.k.a key rotation just print Signer; It means no #1 prefix.
        sha1_signatures = (stdout || "").split("\n")
          .filter { |l| l.index("Signer ") && l.index("SHA-1 digest") }
          .flat_map { |l| l.scan(SHA1_CAPTURE_REGEX) }
          .map { |sig| sig.delete(":").downcase }

        raise AndroidApk::ParsingSignatureError, "the parser cannot get sha1 signatures" if sha1_signatures.empty?

        sha1_signatures
      end
    end
  end
end
