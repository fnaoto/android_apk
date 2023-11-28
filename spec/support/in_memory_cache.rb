class AndroidApk
  class << self
    alias original_analyze analyze

    def analyze(*args)
      caller_in_gem = caller.drop_while { |c| !c.include?("/android_apk/") }[0]

      if caller_in_gem.include?("/android_apk/spec/")
        raise "cache implementation should be re-considered" if args.size != 1
        @_rspec_caches ||= {}
        @_rspec_caches[args[0]] ||= original_analyze(*args)
      else
        original_analyze(*args)
      end
    end
  end
end
