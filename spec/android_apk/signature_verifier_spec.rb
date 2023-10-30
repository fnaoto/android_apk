# frozen_string_literal: true

describe AndroidApk::SignatureVerifier do
  describe "#verify" do
    subject { AndroidApk::SignatureVerifier.verify(filepath: apk_filepath, min_sdk_version: min_sdk_version) }

    context "if an apk has been rotated" do
      let(:min_sdk_version) { 21 }

      let(:apk_filepath) { File.join(FIXTURE_DIR, "signatures", "signature-v3", "app-rotated.apk") }

      it "returns sdk-ranged certificate information order by min_sdk_version asc" do
        expect(subject).to match_array(
                             [
                               {
                                 "min_sdk_version" => 21,
                                 "max_sdk_version" => 23,
                                 "md5" => "1406a3ae028053ad27778af3efe6fbd8",
                                 "sha1" => "eb6cbb57f091e97d614cdc773aa2efc66a39a818",
                                 "sha256" => "4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f"
                               },
                               {
                                 "min_sdk_version" => 24,
                                 "max_sdk_version" => 32,
                                 "md5" => "1406a3ae028053ad27778af3efe6fbd8",
                                 "sha1" => "eb6cbb57f091e97d614cdc773aa2efc66a39a818",
                                 "sha256" => "4ca27e05a684c855ba204c7ee32c1cd0993de95163eae99ba578fc80c28e913f"
                               },
                               {
                                 "min_sdk_version" => 33,
                                 "max_sdk_version" => 2147483647,
                                 "md5" => "4b85af08b8186094d7b90b992b121e8d",
                                 "sha1" => "e9d0dd023bdab7fae9479d1ecbb3275e0fccac20",
                                 "sha256" => "4e8929a7f74291caad2f4c23a547e238d4fd7407a4960af749cf9e38a860e8bc"
                               }
                             ]
                           )
      end
    end

    context "if an apk is not signed" do
      let(:min_sdk_version) { 14 }

      let(:apk_filepath) { File.join(FIXTURE_DIR, "other", "unsigned.apk") }

      it "returns a hash array whose digests are nil" do
        expect(subject.flat_map { |s| s.slice("md5", "sha1", "sha256").values }.compact).to be_empty
      end
    end

    context "if an apk is malformed" do
      let(:min_sdk_version) { 30 } # dummy

      let(:apk_filepath) { File.join(FIXTURE_DIR, ".gitignore") }

      it "raises ApkSignerExecutionError" do
        expect { subject }.to raise_error(AndroidApk::ApkSignerExecutionError, "this file is a malformed apk")
      end
    end

    context "if an apk is signed with RSA" do

      context "if min sdk is 14" do
        let(:min_sdk_version) { 14 }

        context "if only v1 scheme is enabled" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "signatures", "apks-14-v1-true-v2-false/rsa/app-rsa.apk") }

          it "returns sdk-ranged certificate information order by min_sdk_version asc" do
            expect(subject).to match_array(
                                 [
                                   {
                                     "min_sdk_version" => 14,
                                     "max_sdk_version" => 17,
                                     "md5" => "b45d97c0330628008c56837ad9612103",
                                     "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
                                     "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
                                   },
                                   {
                                     "min_sdk_version" => 18,
                                     "max_sdk_version" => 23,
                                     "md5" => "b45d97c0330628008c56837ad9612103",
                                     "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
                                     "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
                                   },
                                   {
                                     "min_sdk_version" => 24,
                                     "max_sdk_version" => 2147483647,
                                     "md5" => "b45d97c0330628008c56837ad9612103",
                                     "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
                                     "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
                                   }
                                 ]
                               )
          end
        end

        context "if only v2 scheme is enabled" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "signatures", "apks-14-v1-false-v2-true/rsa/app-rsa.apk") }

          it "returns sdk-ranged certificate information order by min_sdk_version asc but available section is only min_sdk_version >= 24" do
            expect(subject).to match_array(
                                 [
                                   {
                                     "min_sdk_version" => 14,
                                     "max_sdk_version" => 17,
                                     "md5" => nil,
                                     "sha1" => nil,
                                     "sha256" => nil
                                   },
                                   {
                                     "min_sdk_version" => 18,
                                     "max_sdk_version" => 23,
                                     "md5" => nil,
                                     "sha1" => nil,
                                     "sha256" => nil
                                   },
                                   {
                                     "min_sdk_version" => 24,
                                     "max_sdk_version" => 2147483647,
                                     "md5" => "b45d97c0330628008c56837ad9612103",
                                     "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
                                     "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
                                   }
                                 ]
                               )
          end
        end

        context "if v1 and v2 scheme is enabled" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "signatures", "apks-14-v1-true-v2-true/rsa/app-rsa.apk") }

          it "returns sdk-ranged certificate information order by min_sdk_version asc" do
            expect(subject).to match_array(
                                 [
                                   {
                                     "min_sdk_version" => 14,
                                     "max_sdk_version" => 17,
                                     "md5" => "b45d97c0330628008c56837ad9612103",
                                     "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
                                     "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
                                   },
                                   {
                                     "min_sdk_version" => 18,
                                     "max_sdk_version" => 23,
                                     "md5" => "b45d97c0330628008c56837ad9612103",
                                     "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
                                     "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
                                   },
                                   {
                                     "min_sdk_version" => 24,
                                     "max_sdk_version" => 2147483647,
                                     "md5" => "b45d97c0330628008c56837ad9612103",
                                     "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
                                     "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
                                   }
                                 ]
                               )
          end
        end
      end

      context "if min sdk is 24" do
        let(:min_sdk_version) { 24 }

        context "if only v1 scheme is enabled" do
          # this apk's target sdk is 29
          let(:apk_filepath) { File.join(FIXTURE_DIR, "signatures", "apks-24-v1-true-v2-false/rsa/app-rsa.apk") }

          it "returns sdk-ranged certificate information but nil digests" do
            expect(subject).to match_array(
                                 [
                                   {
                                     "min_sdk_version" => 24,
                                     "max_sdk_version" => 2147483647,
                                     "md5" => "b45d97c0330628008c56837ad9612103",
                                     "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
                                     "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
                                   }
                                 ]
                               )
          end
        end

        context "if only v2 scheme is enabled" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "signatures", "apks-24-v1-false-v2-true/rsa/app-rsa.apk") }

          it "returns sdk-ranged certificate information order by min_sdk_version asc" do
            expect(subject).to match_array(
                                 [
                                   {
                                     "min_sdk_version" => 24,
                                     "max_sdk_version" => 2147483647,
                                     "md5" => "b45d97c0330628008c56837ad9612103",
                                     "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
                                     "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
                                   }
                                 ]
                               )
          end
        end

        context "if v1 and v2 scheme is enabled" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "signatures", "apks-24-v1-true-v2-true/rsa/app-rsa.apk") }

          it "returns sdk-ranged certificate information order by min_sdk_version asc" do
            expect(subject).to match_array(
                                 [
                                   {
                                     "min_sdk_version" => 24,
                                     "max_sdk_version" => 2147483647,
                                     "md5" => "b45d97c0330628008c56837ad9612103",
                                     "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
                                     "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
                                   }
                                 ]
                               )
          end
        end
      end
    end

    context "if an apk is signed with DSA" do

      context "if min sdk is 14" do
        let(:min_sdk_version) { 14 }

        context "if only v1 scheme is enabled" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "signatures", "apks-14-v1-true-v2-false/dsa/app-dsa.apk") }

          it "returns sdk-ranged certificate information order by min_sdk_version asc" do
            expect(subject).to match_array(
                                 [
                                   {
                                     "min_sdk_version" => 14,
                                     "max_sdk_version" => 17,
                                     "md5" => "c83fb009ac2e008be9b62caf9332b39b",
                                     "sha1" => "6a2dd3e16a3f05fc219f914734374065985273b3",
                                     "sha256" => "79122d5315e8c9178f2185fb8a68072a90a9de52d802662c9a32ea8ecf2235f3"
                                   },
                                   {
                                     "min_sdk_version" => 18,
                                     "max_sdk_version" => 23,
                                     "md5" => "c83fb009ac2e008be9b62caf9332b39b",
                                     "sha1" => "6a2dd3e16a3f05fc219f914734374065985273b3",
                                     "sha256" => "79122d5315e8c9178f2185fb8a68072a90a9de52d802662c9a32ea8ecf2235f3"
                                   },
                                   {
                                     "min_sdk_version" => 24,
                                     "max_sdk_version" => 2147483647,
                                     "md5" => "c83fb009ac2e008be9b62caf9332b39b",
                                     "sha1" => "6a2dd3e16a3f05fc219f914734374065985273b3",
                                     "sha256" => "79122d5315e8c9178f2185fb8a68072a90a9de52d802662c9a32ea8ecf2235f3"
                                   }
                                 ]
                               )
          end
        end

        context "if only v2 scheme is enabled" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "signatures", "apks-14-v1-false-v2-true/dsa/app-dsa.apk") }

          it "returns sdk-ranged certificate information order by min_sdk_version asc but available section is only min_sdk_version >= 24" do
            expect(subject).to match_array(
                                 [
                                   {
                                     "min_sdk_version" => 14,
                                     "max_sdk_version" => 17,
                                     "md5" => nil,
                                     "sha1" => nil,
                                     "sha256" => nil
                                   },
                                   {
                                     "min_sdk_version" => 18,
                                     "max_sdk_version" => 23,
                                     "md5" => nil,
                                     "sha1" => nil,
                                     "sha256" => nil
                                   },
                                   {
                                     "min_sdk_version" => 24,
                                     "max_sdk_version" => 2147483647,
                                     "md5" => "c83fb009ac2e008be9b62caf9332b39b",
                                     "sha1" => "6a2dd3e16a3f05fc219f914734374065985273b3",
                                     "sha256" => "79122d5315e8c9178f2185fb8a68072a90a9de52d802662c9a32ea8ecf2235f3"
                                   }
                                 ]
                               )
          end
        end

        context "if v1 and v2 scheme is enabled" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "signatures", "apks-14-v1-true-v2-true/dsa/app-dsa.apk") }

          it "returns sdk-ranged certificate information order by min_sdk_version asc" do
            expect(subject).to match_array(
                                 [
                                   {
                                     "min_sdk_version" => 14,
                                     "max_sdk_version" => 17,
                                     "md5" => "c83fb009ac2e008be9b62caf9332b39b",
                                     "sha1" => "6a2dd3e16a3f05fc219f914734374065985273b3",
                                     "sha256" => "79122d5315e8c9178f2185fb8a68072a90a9de52d802662c9a32ea8ecf2235f3"
                                   },
                                   {
                                     "min_sdk_version" => 18,
                                     "max_sdk_version" => 23,
                                     "md5" => "c83fb009ac2e008be9b62caf9332b39b",
                                     "sha1" => "6a2dd3e16a3f05fc219f914734374065985273b3",
                                     "sha256" => "79122d5315e8c9178f2185fb8a68072a90a9de52d802662c9a32ea8ecf2235f3"
                                   },
                                   {
                                     "min_sdk_version" => 24,
                                     "max_sdk_version" => 2147483647,
                                     "md5" => "c83fb009ac2e008be9b62caf9332b39b",
                                     "sha1" => "6a2dd3e16a3f05fc219f914734374065985273b3",
                                     "sha256" => "79122d5315e8c9178f2185fb8a68072a90a9de52d802662c9a32ea8ecf2235f3"
                                   }
                                 ]
                               )
          end
        end
      end

      context "if min sdk is 24" do
        let(:min_sdk_version) { 24 }

        context "if only v1 scheme is enabled" do
          # this apk's target sdk is 29
          let(:apk_filepath) { File.join(FIXTURE_DIR, "signatures", "apks-24-v1-true-v2-false/dsa/app-dsa.apk") }

          it "returns sdk-ranged certificate information but nil digests" do
            expect(subject).to match_array(
                                 [
                                   {
                                     "min_sdk_version" => 24,
                                     "max_sdk_version" => 2147483647,
                                     "md5" => "c83fb009ac2e008be9b62caf9332b39b",
                                     "sha1" => "6a2dd3e16a3f05fc219f914734374065985273b3",
                                     "sha256" => "79122d5315e8c9178f2185fb8a68072a90a9de52d802662c9a32ea8ecf2235f3"
                                   }
                                 ]
                               )
          end
        end

        context "if only v2 scheme is enabled" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "signatures", "apks-24-v1-false-v2-true/dsa/app-dsa.apk") }

          it "returns sdk-ranged certificate information order by min_sdk_version asc" do
            expect(subject).to match_array(
                                 [
                                   {
                                     "min_sdk_version" => 24,
                                     "max_sdk_version" => 2147483647,
                                     "md5" => "c83fb009ac2e008be9b62caf9332b39b",
                                     "sha1" => "6a2dd3e16a3f05fc219f914734374065985273b3",
                                     "sha256" => "79122d5315e8c9178f2185fb8a68072a90a9de52d802662c9a32ea8ecf2235f3"
                                   }
                                 ]
                               )
          end
        end

        context "if v1 and v2 scheme is enabled" do
          let(:apk_filepath) { File.join(FIXTURE_DIR, "signatures", "apks-24-v1-true-v2-true/dsa/app-dsa.apk") }

          it "returns sdk-ranged certificate information order by min_sdk_version asc" do
            expect(subject).to match_array(
                                 [
                                   {
                                     "min_sdk_version" => 24,
                                     "max_sdk_version" => 2147483647,
                                     "md5" => "c83fb009ac2e008be9b62caf9332b39b",
                                     "sha1" => "6a2dd3e16a3f05fc219f914734374065985273b3",
                                     "sha256" => "79122d5315e8c9178f2185fb8a68072a90a9de52d802662c9a32ea8ecf2235f3"
                                   }
                                 ]
                               )
          end
        end
      end
    end
  end
end
