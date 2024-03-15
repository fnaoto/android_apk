# frozen_string_literal: true

class AndroidApk
  class Error < StandardError; end

  class ApkFileNotFoundError < Error; end

  # @!attribute [r] stdout
  #   @return [String, nil] Standard output of a command
  # @!attribute [r] stderr
  #   @return [String, nil] Standard error of a command
  class Aapt2Error < Error
    attr_reader :stdout, :stderr

    def initialize(message:, stdout:, stderr:)
      super(message)
      @stdout = stdout
      @stderr = stderr
    end
  end

  # This error wIll be thrown if an apk is invalid or contains invalid files.
  class InvalidApkError < Error; end

  class ApkSignerExecutionError < Error; end
  class ParsingSignatureError < Error; end
end
