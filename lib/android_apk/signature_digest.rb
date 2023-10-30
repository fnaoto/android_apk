# frozen_string_literal: true

class AndroidApk
  module SignatureDigest
    MD5 = "md5"
    SHA1 = "sha1"
    SHA256 = "sha256"

    DIGEST_REGEX = /\A[0-9a-zA-Z]{32,}\z/.freeze

    # @param digest [String]
    # @return [String] digest method
    def self.judge(digest:)
      raise "only hex-digest is supported" unless digest =~ DIGEST_REGEX

      case digest.length
      when 32
        ::AndroidApk::SignatureDigest::MD5
      when 40
        ::AndroidApk::SignatureDigest::SHA1
      when 64
        ::AndroidApk::SignatureDigest::SHA256
      else
        raise "#{digest.length}-length digest is not supported"
      end
    end
  end
end
