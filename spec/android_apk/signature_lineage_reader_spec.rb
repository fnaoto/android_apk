# frozen_string_literal: true

describe AndroidApk::SignatureLineageReader do
  describe "#read" do
    subject { AndroidApk::SignatureLineageReader.read(filepath: apk_filepath) }

    context "if an apk is unsigned" do
      let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "unsigned.apk") }

      it "returns an empty array" do
        expect(subject).to be_empty
      end
    end

    context "if an apk is v1-and-v2 schemes" do
      let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v1-and-v2.apk") }

      it "returns an empty array" do
        expect(subject).to be_empty
      end
    end

    context "if an apk is v1-and-v3.1 schemes" do
      let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v1-and-v3.1.apk") }

      it "returns certificate information order by signing timing asc" do
        expect(subject).to match_array(
                             [
                               {
                                 "installed data" => true,
                                 "shared uid" => true,
                                 "permission" => true,
                                 "rollback" => false,
                                 "auth" => true,
                                 "md5" => "1406a3ae028053ad27778af3efe6fbd8",
                                 "sha1" => "eb6cbb57f091e97d614cdc773aa2efc66a39a818",
                                 "sha256" => "4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f"
                               },
                               {
                                 "installed data" => true,
                                 "shared uid" => true,
                                 "permission" => true,
                                 "rollback" => false,
                                 "auth" => true,
                                 "md5" => "4b85af08b8186094d7b90b992b121e8d",
                                 "sha1" => "e9d0dd023bdab7fae9479d1ecbb3275e0fccac20",
                                 "sha256" => "4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc"
                               }
                             ]
                           )
      end
    end

    context "if an apk is v1-and-v3 schemes" do
      let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v1-and-v3.apk") }

      it "returns certificate information order by signing timing asc" do
        expect(subject).to match_array(
                             [
                               {
                                 "installed data" => true,
                                 "shared uid" => true,
                                 "permission" => true,
                                 "rollback" => false,
                                 "auth" => true,
                                 "md5" => "1406a3ae028053ad27778af3efe6fbd8",
                                 "sha1" => "eb6cbb57f091e97d614cdc773aa2efc66a39a818",
                                 "sha256" => "4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f"
                               },
                               {
                                 "installed data" => true,
                                 "shared uid" => true,
                                 "permission" => true,
                                 "rollback" => false,
                                 "auth" => true,
                                 "md5" => "4b85af08b8186094d7b90b992b121e8d",
                                 "sha1" => "e9d0dd023bdab7fae9479d1ecbb3275e0fccac20",
                                 "sha256" => "4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc"
                               }
                             ]
                           )
      end
    end

    context "if an apk is v1-scheme" do
      let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v1-only.apk") }

      it "returns an empty array" do
        expect(subject).to be_empty
      end
    end

    context "if an apk is v2-scheme" do
      let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v2-only.apk") }

      it "returns an empty array" do
        expect(subject).to be_empty
      end
    end

    context "if an apk is v3.1-scheme" do
      let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v3.1.apk") }

      it "returns certificate information order by signing timing asc" do
        expect(subject).to match_array(
                             [
                               {
                                 "installed data" => true,
                                 "shared uid" => true,
                                 "permission" => true,
                                 "rollback" => false,
                                 "auth" => true,
                                 "md5" => "1406a3ae028053ad27778af3efe6fbd8",
                                 "sha1" => "eb6cbb57f091e97d614cdc773aa2efc66a39a818",
                                 "sha256" => "4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f"
                               },
                               {
                                 "installed data" => true,
                                 "shared uid" => true,
                                 "permission" => true,
                                 "rollback" => false,
                                 "auth" => true,
                                 "md5" => "4b85af08b8186094d7b90b992b121e8d",
                                 "sha1" => "e9d0dd023bdab7fae9479d1ecbb3275e0fccac20",
                                 "sha256" => "4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc"
                               }
                             ]
                           )
      end
    end

    context "if an apk is v3-scheme" do
      let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v3.apk") }

      it "returns certificate information order by signing timing asc" do
        expect(subject).to match_array(
                             [
                               {
                                 "installed data" => true,
                                 "shared uid" => true,
                                 "permission" => true,
                                 "rollback" => false,
                                 "auth" => true,
                                 "md5" => "1406a3ae028053ad27778af3efe6fbd8",
                                 "sha1" => "eb6cbb57f091e97d614cdc773aa2efc66a39a818",
                                 "sha256" => "4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f"
                               },
                               {
                                 "installed data" => true,
                                 "shared uid" => true,
                                 "permission" => true,
                                 "rollback" => false,
                                 "auth" => true,
                                 "md5" => "4b85af08b8186094d7b90b992b121e8d",
                                 "sha1" => "e9d0dd023bdab7fae9479d1ecbb3275e0fccac20",
                                 "sha256" => "4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc"
                               }
                             ]
                           )
      end
    end

    context "if an apk is malformed" do
      let(:apk_filepath) { File.join(FIXTURE_DIR, ".gitignore") }

      it "returns an empty array" do
        expect(subject).to be_empty
      end
    end
  end
end
