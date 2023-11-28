# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "android_apk/version"

Gem::Specification.new do |spec|
  spec.name = "android_apk"
  spec.version = AndroidApk::VERSION
  spec.authors = ["Kyosuke Inoue"]
  spec.email = ["kyoro@hakamastyle.net"]
  spec.description = "This library can analyze Android APK application package. You can get any information of android apk file."
  spec.summary = "Android APK file analyzer"
  spec.homepage = "https://github.com/DeployGate/android_apk"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.files = `git ls-files | grep -v 'spec/fixture'`.split($/)
  spec.require_paths = ["lib"]

  spec.extra_rdoc_files = %w(LICENSE.txt README.md)

  spec.add_dependency "rubyzip", "~> 2.3.0"

  spec.metadata["rubygems_mfa_required"] = "true"
end
