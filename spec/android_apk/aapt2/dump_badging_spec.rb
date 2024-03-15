# frozen_string_literal: true

describe AndroidApk::Aapt2::DumpBadging do
  let(:aapt2) { AndroidApk::Aapt2::DumpBadging.new(apk_filepath: apk_filepath) }

  describe "#parse" do
    let(:result) { aapt2.parse }

    context "if invalid sample apk files are given" do
      cases = [
        {
          filepath: fixture_file("invalid", "no_android_manifest.apk"),
          error: AndroidApk::InvalidApkError,
          error_message: "This apk file is an invalid zip-format or contains no AndroidManifest.xml"
        },
        {
          filepath: fixture_file("invalid", "corrupt_manifest.apk"),
          error: AndroidApk::InvalidApkError,
          error_message: "AndroidManifest.xml seems to be invalid and not decode-able."
        },
        {
          filepath: fixture_file("invalid", "multi_application_tag.apk"),
          error: AndroidApk::InvalidApkError,
          error_message: "duplicates of application tag in AndroidManifest.xml are invalid."
        },
      ]

      cases.each do |c|
        context "for #{c[:filepath]}" do
          let(:apk_filepath) { c[:filepath] }

          it { expect { result }.to raise_error(c[:error], c[:error_message]) }
        end
      end
    end

    context "if an apk contains meta-tags" do
      let(:apk_filepath) { fixture_file("meta-tag", "include-sdk.apk") }

      it "contains sdk meta data" do
        expect(result.meta_data).to eq(
          {
            "com.deploygate.sdk.version" => "4",
            "com.deploygate.sdk.artifact_version" => "4.6.1",
            "com.deploygate.sdk.feature_flags" => "31"
          }
        )
      end
    end

    context "if an apk does not contain meta-tags" do
      let(:apk_filepath) { fixture_file("meta-tag", "no-meta-tag.apk") }

      it { expect(result.meta_data).to be_empty }
    end
  end
end
