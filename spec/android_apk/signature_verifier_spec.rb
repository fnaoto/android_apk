# frozen_string_literal: true

describe AndroidApk::SignatureVerifier do
  describe "#verify" do
    subject { AndroidApk::SignatureVerifier.verify(filepath: apk_filepath, target_sdk_version: 32) }

    context "if an apk is signature v3" do
      let(:apk_filepath) { File.join(FIXTURE_DIR, "signatures", "signature-v3", "app-rotated.apk") }

      it "returns the signature trust lineage whose 1st element is the signing signature" do
        expect(subject).to match_array(%w(e9d0dd023bdab7fae9479d1ecbb3275e0fccac20 eb6cbb57f091e97d614cdc773aa2efc66a39a818))
      end
    end

    context "if an apk is not signed" do
      let(:apk_filepath) { File.join(FIXTURE_DIR, "other", "unsigned.apk") }

      it "returns an empty array" do
        expect(subject).to be_empty
      end
    end

    context "if an apk is malformed" do
      let(:apk_filepath) { File.join(FIXTURE_DIR, ".gitignore") }

      it "raises ApkSignerExecutionError" do
        expect { subject }.to raise_error(AndroidApk::ApkSignerExecutionError, "this file is a malformed apk")
      end
    end

    %w(rsa dsa).each do |sig_method|
      context "signed with #{sig_method}" do
        let(:signing) { sig_method }
        let(:signature) do
          {
            "rsa" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
            "dsa" => "6a2dd3e16a3f05fc219f914734374065985273b3"
          }[signing]
        end

        %w(14 24).each do |sdk|
          context "in apks-#{sdk}" do
            let(:min_sdk) { sdk }

            [
              [true, true],
              [true, false],
              [false, true]
            ].each do |v1, v2|
              context "v1 signed? == #{v1} and v2 signed? == #{v2}" do
                let(:v1_enabled) { v1 }
                let(:v2_enabled) { v2 }

                let(:apk_filepath) { File.join(FIXTURE_DIR, "signatures", "apks-#{min_sdk}-v1-#{v1_enabled}-v2-#{v2_enabled}/#{signing}/app-#{signing}.apk") }

                it { expect(subject).to match_array([signature]) }
              end
            end
          end
        end
      end
    end
  end
end
