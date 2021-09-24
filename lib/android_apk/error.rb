class AndroidApk
  class Error < StandardError; end

  class ApkFileNotFoundError < Error; end
  class UnacceptableApkError < Error; end
  class AndroidManifestValidateError < Error; end
end