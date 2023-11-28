# frozen_string_literal: true

describe AndroidApk::SignatureVerifier do
  let(:previous_certificate) do
    {
      "md5" => "1406a3ae028053ad27778af3efe6fbd8",
      "sha1" => "eb6cbb57f091e97d614cdc773aa2efc66a39a818",
      "sha256" => "4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f"
    }
  end
  let(:new_certificate) do
    {
      "md5" => "4b85af08b8186094d7b90b992b121e8d",
      "sha1" => "e9d0dd023bdab7fae9479d1ecbb3275e0fccac20",
      "sha256" => "4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc"
    }
  end

  describe "#verify" do
    subject { AndroidApk::SignatureVerifier.verify(filepath: apk_filepath, min_sdk_version: min_sdk_version) }

    context "with exceptions" do
      let(:min_sdk_version) { 23 }

      context "if an apk is unsigned" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "unsigned.apk") }

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
    end

    context "if min sdk does not support v2 scheme" do
      let(:min_sdk_version) { 23 }

      context "if an apk is v1-and-v2 scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v1-and-v2.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 2_147_483_647
            }.merge(previous_certificate)
          ]
        end

        it "returns sdk-ranged certificate information of the previous signer" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v1-and-v2-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v1-and-v3.1 scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v1-and-v3.1.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 32
            }.merge(previous_certificate),
            {
              "min_sdk_version" => 33,
              "max_sdk_version" => 2_147_483_647
            }.merge(new_certificate)
          ]
        end

        it "returns sdk-ranged certificate information but new signer is applied only for 33 or later" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v1-and-v3.1-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v1-and-v3 scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v1-and-v3.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 27
            }.merge(previous_certificate),
            {
              "min_sdk_version" => 28,
              "max_sdk_version" => 2_147_483_647
            }.merge(new_certificate)
          ]
        end

        it "returns sdk-ranged certificate information but new signer is applied only for 24 or later" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v1-and-v3-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v1-only scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v1-only.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 23
            }.merge(previous_certificate)
          ]
        end

        it "returns sdk-ranged certificate information only for devices that do not support v2" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v1-only-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v2-only scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v2-only.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => 24,
              "max_sdk_version" => 2_147_483_647
            }.merge(previous_certificate)
          ]
        end

        it "returns sdk-ranged certificate information only for devices that support v2" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v2-only-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v3.1 scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v3.1.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => 24,
              "max_sdk_version" => 32
            }.merge(previous_certificate),
            {
              "min_sdk_version" => 33,
              "max_sdk_version" => 2_147_483_647
            }.merge(new_certificate)
          ]
        end

        it "returns sdk-ranged certificate information only for devices that support v2 and new signer applied only for API 33 or later" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v3.1-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v3-scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v3.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => 24,
              "max_sdk_version" => 27
            }.merge(previous_certificate),
            {
              "min_sdk_version" => 28,
              "max_sdk_version" => 2_147_483_647
            }.merge(new_certificate)
          ]
        end

        it "returns sdk-ranged certificate information but new signer is applied only for API 24 or later" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "m-v2required", "v3-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end
    end

    context "if an apk supports v2 but not v3" do
      let(:min_sdk_version) { 27 }

      context "if an apk is v1-and-v2 scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "o1-v2required", "v1-and-v2.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 2_147_483_647
            }.merge(previous_certificate)
          ]
        end

        it "returns sdk-ranged certificate information of the previous signer" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "o1-v2required", "v1-and-v2-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v1-and-v3.1 scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "o1-v2required", "v1-and-v3.1.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 32
            }.merge(previous_certificate),
            {
              "min_sdk_version" => 33,
              "max_sdk_version" => 2_147_483_647
            }.merge(new_certificate)
          ]
        end

        it "returns sdk-ranged certificate information but new signer is applied only for 33 or later" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "o1-v2required", "v1-and-v3.1-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v1-and-v3 scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "o1-v2required", "v1-and-v3.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 27
            }.merge(previous_certificate),
            {
              "min_sdk_version" => 28,
              "max_sdk_version" => 2_147_483_647
            }.merge(new_certificate)
          ]
        end

        it "returns sdk-ranged certificate information but new signer is applied only for 27 or later" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "o1-v2required", "v1-and-v3-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v1-only scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "o1-v2required", "v1-only.apk") }

        it "returns an empty array" do
          expect(subject).to be_empty
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "o1-v2required", "v1-only-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to be_empty
          end
        end
      end

      context "if an apk is v2-only scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "o1-v2required", "v2-only.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 2_147_483_647
            }.merge(previous_certificate)
          ]
        end

        it "returns sdk-ranged certificate information only for all devices" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "o1-v2required", "v2-only-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v3.1 scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "o1-v2required", "v3.1.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 32
            }.merge(previous_certificate),
            {
              "min_sdk_version" => 33,
              "max_sdk_version" => 2_147_483_647
            }.merge(new_certificate)
          ]
        end

        it "returns sdk-ranged certificate information only for devices that support v2 and new signer applied only for API 33 or later" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "o1-v2required", "v3.1-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v3-scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "o1-v2required", "v3.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 27
            }.merge(previous_certificate),
            {
              "min_sdk_version" => 28,
              "max_sdk_version" => 2_147_483_647
            }.merge(new_certificate)
          ]
        end

        it "returns sdk-ranged certificate information and new signer is applied only for all devices" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "o1-v2required", "v3-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end
    end

    context "if an apk supports v3" do
      let(:min_sdk_version) { 32 }

      context "if an apk is v1-and-v2 scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "s2-v2required", "v1-and-v2.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 2_147_483_647
            }.merge(previous_certificate)
          ]
        end

        it "returns sdk-ranged certificate information of the previous signer" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "s2-v2required", "v1-and-v2-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v1-and-v3.1 scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "s2-v2required", "v1-and-v3.1.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 32
            }.merge(previous_certificate),
            {
              "min_sdk_version" => 33,
              "max_sdk_version" => 2_147_483_647
            }.merge(new_certificate)
          ]
        end

        it "returns sdk-ranged certificate information but new signer is applied only for 33 or later" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "s2-v2required", "v1-and-v3.1-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v1-and-v3 scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "s2-v2required", "v1-and-v3.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 2_147_483_647
            }.merge(new_certificate)
          ]
        end

        it "returns sdk-ranged certificate information but new signer is applied only for 32 or later" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "s2-v2required", "v1-and-v3-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v1-only scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "s2-v2required", "v1-only.apk") }

        it "returns an empty array" do
          expect(subject).to be_empty
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "s2-v2required", "v1-only-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to be_empty
          end
        end
      end

      context "if an apk is v2-only scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "s2-v2required", "v2-only.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 2_147_483_647
            }.merge(previous_certificate)
          ]
        end

        it "returns sdk-ranged certificate information only for all devices" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "s2-v2required", "v2-only-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v3.1 scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "s2-v2required", "v3.1.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 32
            }.merge(previous_certificate),
            {
              "min_sdk_version" => 33,
              "max_sdk_version" => 2_147_483_647
            }.merge(new_certificate)
          ]
        end

        it "returns sdk-ranged certificate information only for devices that support v2 and new signer applied only for API 33 or later" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "s2-v2required", "v3.1-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v3-scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "s2-v2required", "v3.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 2_147_483_647
            }.merge(new_certificate)
          ]
        end

        it "returns sdk-ranged certificate information and new signer is applied only for all devices" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "s2-v2required", "v3-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end
    end

    context "if an apk supports v3.1" do
      let(:min_sdk_version) { 33 }

      context "if an apk is v1-and-v2 scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "t-v2required", "v1-and-v2.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 2_147_483_647
            }.merge(previous_certificate)
          ]
        end

        it "returns sdk-ranged certificate information of the previous signer" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "t-v2required", "v1-and-v2-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v1-and-v3.1 scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "t-v2required", "v1-and-v3.1.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 2_147_483_647
            }.merge(new_certificate)
          ]
        end

        it "returns sdk-ranged certificate information of the new signer" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "t-v2required", "v1-and-v3.1-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v1-and-v3 scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "t-v2required", "v1-and-v3.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 2_147_483_647
            }.merge(new_certificate)
          ]
        end

        it "returns sdk-ranged certificate information and new signer is applied only for all devices" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "t-v2required", "v1-and-v3-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v1-only scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "t-v2required", "v1-only.apk") }

        it "returns an empty array" do
          expect(subject).to be_empty
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "t-v2required", "v1-only-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to be_empty
          end
        end
      end

      context "if an apk is v2-only scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "t-v2required", "v2-only.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 2_147_483_647
            }.merge(previous_certificate)
          ]
        end

        it "returns sdk-ranged certificate information only for all devices" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "t-v2required", "v2-only-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v3.1 scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "t-v2required", "v3.1.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 2_147_483_647
            }.merge(new_certificate)
          ]
        end

        it "returns sdk-ranged certificate information and new signer is applied only for all devices" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "t-v2required", "v3.1-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end

      context "if an apk is v3-scheme" do
        let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "t-v2required", "v3.apk") }
        let(:expected_fingerprints) do
          [
            {
              "min_sdk_version" => min_sdk_version,
              "max_sdk_version" => 2_147_483_647
            }.merge(new_certificate)
          ]
        end

        it "returns sdk-ranged certificate information and new signer is applied only for all devices" do
          expect(subject).to match_array(expected_fingerprints)
        end

        context "with source stamp" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "scheme-combination-apks", "t-v2required", "v3-with-source-stamp.apk") }

          it "returns the same results without source stamp" do
            expect(subject).to match_array(expected_fingerprints)
          end
        end
      end
    end
  end
end
