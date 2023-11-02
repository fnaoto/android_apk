# frozen_string_literal: true

describe AndroidApk::SignatureDigest do
  describe "#judge" do
    subject { AndroidApk::SignatureDigest.judge(digest: digest) }

    context "if a digest is based on md5" do
      let(:digest) { "4b85af08b8186094d7b90b992b121e8d" }

      it { is_expected.to eq("md5") }
    end

    context "if a digest is based on sha1" do
      let(:digest) { "eb6cbb57f091e97d614cdc773aa2efc66a39a818" }

      it { is_expected.to eq("sha1") }
    end

    context "if a digest is based on sha256" do
      let(:digest) { "4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f" }

      it { is_expected.to eq("sha256") }
    end

    context "if a digest is not any of md5, sha1 and sha256" do
      let(:digest) { "4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f3f3f" }

      it { expect { subject }.to raise_error("68-length digest is not supported") }
    end

    context "if a value is not a hex-digest" do
      let(:digest) { "hello world" }

      it { expect { subject }.to raise_error("only hex-digest is supported") }
    end
  end
end
