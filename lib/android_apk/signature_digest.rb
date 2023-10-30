class AndroidApk
  module SignatureDigest
    MD5 = 'md5'.freeze
    SHA1 = 'sha1'.freeze
    SHA256 = 'sha256'.freeze

    DIGEST_REGEX = /\A[0-9a-zA-Z]{32,}\z/

    # @param digest [String]
    # @return [String] digest method
    def self.judge(digest:)
      raise "only hex-digest is supported" unless digest =~ DIGEST_REGEX

      if digest.length == 32
        ::AndroidApk::SignatureDigest::MD5
      elsif digest.length == 40
        ::AndroidApk::SignatureDigest::SHA1
      elsif digest.length == 64
        ::AndroidApk::SignatureDigest::SHA256
      else
        raise "#{digest.length}-length digest is not supported"
      end
    end
  end
end