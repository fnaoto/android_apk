# frozen_string_literal: true

class AndroidApk
  class Error < StandardError; end

  class ApkFileNotFoundError < Error; end
  class UnacceptableApkError < Error; end
  class AndroidManifestValidateError < Error
    def initialize(tag)
      super("duplicates of #{tag} tag in AndroidManifest.xml are invalid.")
    end
  end
end
