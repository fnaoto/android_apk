# frozen_string_literal: true

describe AndroidApk::AppSignature do
  describe "#fingerprints" do
    let(:app_signature) { AndroidApk::AppSignature.new(lineages: [], fingerprints: fingerprints) }

    context "if fingerprints is empty" do
      let(:fingerprints) { [] }

      it { expect(app_signature.fingerprints).to be_empty }
    end

    context "if fingerprints is a multiple-element nil-digest array" do
      let(:fingerprints) do
        [
          {
            "min_sdk_version" => 15,
            "max_sdk_version" => 23,
            "md5" => nil,
            "sha1" => nil,
            "sha256" => nil
          },
          {
            "min_sdk_version" => 24,
            "max_sdk_version" => 2_147_483_647,
            "md5" => nil,
            "sha1" => nil,
            "sha256" => nil
          }
        ]
      end

      it { expect(app_signature.fingerprints).to be_empty }
    end

    context "if fingerprints is a combination of nil/present-digest array" do
      let(:fingerprints) do
        [
          {
            "min_sdk_version" => 15,
            "max_sdk_version" => 23,
            "md5" => nil,
            "sha1" => nil,
            "sha256" => nil
          },
          {
            "min_sdk_version" => 24,
            "max_sdk_version" => 2_147_483_647,
            "md5" => "b45d97c0330628008c56837ad9612103",
            "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
            "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
          }
        ]
      end

      it "returns a ranged information that covert the given sdk version" do
        expect(app_signature.fingerprints).to match_array(
          [
            {
              "min_sdk_version" => 24,
              "max_sdk_version" => 2_147_483_647,
              "md5" => "b45d97c0330628008c56837ad9612103",
              "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
              "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
            }
          ]
        )
      end
    end

    context "if fingerprints is a multiple present-digest array" do
      let(:fingerprints) do
        [
          {
            "min_sdk_version" => 15,
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
            "max_sdk_version" => 2_147_483_647,
            "md5" => "b45d97c0330628008c56837ad9612103",
            "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
            "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
          }
        ]
      end

      it "returns a concatenated information" do
        expect(app_signature.fingerprints).to match_array(
          [
            {
              "min_sdk_version" => 15,
              "max_sdk_version" => 2_147_483_647,
              "md5" => "b45d97c0330628008c56837ad9612103",
              "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
              "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
            }
          ]
        )
      end
    end

    context "if fingerprints is a multiple present-digest array" do
      let(:fingerprints) do
        [
          {
            "min_sdk_version" => 15,
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
            "max_sdk_version" => 2_147_483_647,
            "md5" => "c83fb009ac2e008be9b62caf9332b39b",
            "sha1" => "6a2dd3e16a3f05fc219f914734374065985273b3",
            "sha256" => "79122d5315e8c9178f2185fb8a68072a90a9de52d802662c9a32ea8ecf2235f3"
          }
        ]
      end

      it "returns a concatenated information" do
        expect(app_signature.fingerprints).to match_array(
          [
            {
              "min_sdk_version" => 15,
              "max_sdk_version" => 23,
              "md5" => "b45d97c0330628008c56837ad9612103",
              "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
              "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
            },
            {
              "min_sdk_version" => 24,
              "max_sdk_version" => 2_147_483_647,
              "md5" => "c83fb009ac2e008be9b62caf9332b39b",
              "sha1" => "6a2dd3e16a3f05fc219f914734374065985273b3",
              "sha256" => "79122d5315e8c9178f2185fb8a68072a90a9de52d802662c9a32ea8ecf2235f3"
            }
          ]
        )
      end
    end
  end

  describe "#get_fingerprint" do
    let(:app_signature) { AndroidApk::AppSignature.new(lineages: [], fingerprints: fingerprints) }

    context "if fingerprints is empty" do
      let(:fingerprints) { [] }

      it { expect(app_signature.get_fingerprint(sdk_version: 30)).to be_nil }
    end

    context "if fingerprints is a combination of nil/present-digest array" do
      let(:fingerprints) do
        [
          {
            "min_sdk_version" => 15,
            "max_sdk_version" => 23,
            "md5" => nil,
            "sha1" => nil,
            "sha256" => nil
          },
          {
            "min_sdk_version" => 24,
            "max_sdk_version" => 2_147_483_647,
            "md5" => "b45d97c0330628008c56837ad9612103",
            "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
            "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
          }
        ]
      end

      it "returns a ranged information that covert the given sdk version" do
        expect(app_signature.get_fingerprint(sdk_version: 30)).to eq(
          {
            "min_sdk_version" => 24,
            "max_sdk_version" => 2_147_483_647,
            "md5" => "b45d97c0330628008c56837ad9612103",
            "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
            "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
          }
        )
        expect(app_signature.get_fingerprint(sdk_version: 16)).to be_nil
      end
    end

    context "if fingerprints is a multiple present-digest array" do
      let(:fingerprints) do
        [
          {
            "min_sdk_version" => 15,
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
            "max_sdk_version" => 2_147_483_647,
            "md5" => "b45d97c0330628008c56837ad9612103",
            "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
            "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
          }
        ]
      end

      it "returns a concatenated information that covert the given sdk version" do
        expect(app_signature.get_fingerprint(sdk_version: 30)).to eq(
          {
            "min_sdk_version" => 15,
            "max_sdk_version" => 2_147_483_647,
            "md5" => "b45d97c0330628008c56837ad9612103",
            "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
            "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
          }
        )
      end
    end

    context "if fingerprints is a multiple present-digest array" do
      let(:fingerprints) do
        [
          {
            "min_sdk_version" => 15,
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
            "max_sdk_version" => 2_147_483_647,
            "md5" => "c83fb009ac2e008be9b62caf9332b39b",
            "sha1" => "6a2dd3e16a3f05fc219f914734374065985273b3",
            "sha256" => "79122d5315e8c9178f2185fb8a68072a90a9de52d802662c9a32ea8ecf2235f3"
          }
        ]
      end

      it "returns a concatenated information that covert the given sdk version" do
        expect(app_signature.get_fingerprint(sdk_version: 21)).to eq(
          {
            "min_sdk_version" => 15,
            "max_sdk_version" => 23,
            "md5" => "b45d97c0330628008c56837ad9612103",
            "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
            "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
          }
        )
        expect(app_signature.get_fingerprint(sdk_version: 30)).to eq(
          {
            "min_sdk_version" => 24,
            "max_sdk_version" => 2_147_483_647,
            "md5" => "c83fb009ac2e008be9b62caf9332b39b",
            "sha1" => "6a2dd3e16a3f05fc219f914734374065985273b3",
            "sha256" => "79122d5315e8c9178f2185fb8a68072a90a9de52d802662c9a32ea8ecf2235f3"
          }
        )
      end
    end
  end

  describe "#unsigned?" do
    let(:app_signature) { AndroidApk::AppSignature.new(lineages: [], fingerprints: fingerprints) }

    subject { app_signature.unsigned? }

    context "if fingerprints is empty" do
      let(:fingerprints) { [] }

      it { is_expected.to be_truthy }
    end

    context "if fingerprints is a single-element nil-digest array" do
      let(:fingerprints) do
        [
          {
            "min_sdk_version" => 24,
            "max_sdk_version" => 2_147_483_647,
            "md5" => nil,
            "sha1" => nil,
            "sha256" => nil
          }
        ]
      end

      it { is_expected.to be_truthy }
    end

    context "if fingerprints is a multiple-element nil-digest array" do
      let(:fingerprints) do
        [
          {
            "min_sdk_version" => 15,
            "max_sdk_version" => 23,
            "md5" => nil,
            "sha1" => nil,
            "sha256" => nil
          },
          {
            "min_sdk_version" => 24,
            "max_sdk_version" => 2_147_483_647,
            "md5" => nil,
            "sha1" => nil,
            "sha256" => nil
          }
        ]
      end

      it { is_expected.to be_truthy }
    end

    context "if fingerprints is a single-element present-digest array" do
      let(:fingerprints) do
        [
          {
            "min_sdk_version" => 24,
            "max_sdk_version" => 2_147_483_647,
            "md5" => "b45d97c0330628008c56837ad9612103",
            "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
            "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
          }
        ]
      end

      it { is_expected.to be_falsey }
    end

    context "if fingerprints is a combination of nil/present-digest array" do
      let(:fingerprints) do
        [
          {
            "min_sdk_version" => 15,
            "max_sdk_version" => 23,
            "md5" => nil,
            "sha1" => nil,
            "sha256" => nil
          },
          {
            "min_sdk_version" => 24,
            "max_sdk_version" => 2_147_483_647,
            "md5" => "b45d97c0330628008c56837ad9612103",
            "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
            "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
          }
        ]
      end

      it { is_expected.to be_falsey }
    end
  end

  describe "#rotated?" do
    let(:app_signature) { AndroidApk::AppSignature.new(lineages: lineages, fingerprints: fingerprints) }
    let(:fingerprints) do
      [
        {
          "min_sdk_version" => 24,
          "max_sdk_version" => 2_147_483_647,
          "md5" => "b45d97c0330628008c56837ad9612103",
          "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
          "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
        }
      ]
    end

    subject { app_signature.rotated? }

    context "if lineages is empty" do
      let(:lineages) { [] }

      it { is_expected.to be_falsey }
    end

    context "if lineages is a list" do
      let(:lineages) do
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
      end

      it { is_expected.to be_truthy }
    end
  end

  describe "#self.get_target_certificate" do
    let(:app_signature_to) { AndroidApk::AppSignature.new(lineages: lineages_to, fingerprints: fingerprints_to) }
    let(:sdk_version) { 24 }

    subject { AndroidApk::AppSignature.get_target_certificate(certificate_from: certificate_from, lineages_from: lineages_from, app_signature_to: app_signature_to, sdk_version: sdk_version) }

    let(:certificate_a) do
      {
        "md5" => "b45d97c0330628008c56837ad9612103",
        "sha1" => "4ad4e4376face4e441a3b8802363a7f6c6b458ab",
        "sha256" => "901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f4cca431d1692119"
      }
    end
    let(:certificate_b) do
      {
        "md5" => "08c56837ad961210b45d97c033062803",
        "sha1" => "a3b8802363a7f6c6b458ab4ad4e4376face4e441",
        "sha256" => "c0552196f9347c009e2864af44ac0e77ab901ee5b342ed87f4cca431d1692119"
      }
    end
    let(:certificate_c) do
      {
        "md5" => "30628008c56837ad9612b45d97c03103",
        "sha1" => "7f6c6b4584ad4e4376face4e441a3b8802363aab",
        "sha256" => "4cca431d169211901ee5b342ed8c0552196f9347c009e2864af44ac0e77ab7f9"
      }
    end

    context "if the current apk is not rotated (cert a)" do
      let(:lineages_from) { [] }
      let(:certificate_from) { certificate_a }

      context "if the target apk is unsigned" do
        let(:lineages_to) { [] }
        let(:fingerprints_to) { [] }

        it { is_expected.to be_nil }
      end

      context "if the target apk is not rotated" do
        let(:lineages_to) { [] }

        context "and it's the same to the current one" do
          let(:fingerprints_to) do
            [
              {
                "min_sdk_version" => 24,
                "max_sdk_version" => 2_147_483_647
              }.merge(certificate_from)
            ]
          end

          it "behaves as direct-update" do
            is_expected.to eq(certificate_from)
          end
        end

        context "and it's signed by certificate b" do
          let(:fingerprints_to) do
            [
              {
                "min_sdk_version" => 24,
                "max_sdk_version" => 2_147_483_647
              }.merge(certificate_b)
            ]
          end

          it { is_expected.to be_nil }
        end

        context "and it's rotated" do
          context "but the new signer is the current one: c -> a" do
            let(:lineages_to) do
              [
                {
                  "installed data" => true,
                  "shared uid" => true,
                  "permission" => true,
                  "rollback" => false,
                  "auth" => true
                }.merge(certificate_c),
                {
                  "installed data" => true,
                  "shared uid" => true,
                  "permission" => true,
                  "rollback" => false,
                  "auth" => true
                }.merge(certificate_from)
              ]
            end
            let(:fingerprints_to) do
              [
                {
                  "min_sdk_version" => 24,
                  "max_sdk_version" => 32
                }.merge(certificate_c),
                {
                  "min_sdk_version" => 33,
                  "max_sdk_version" => 2_147_483_647
                }.merge(certificate_from)
              ]
            end

            context "if the device does not support key rotation" do
              let(:sdk_version) { 27 }

              it { is_expected.to be_nil }
            end

            context "if the device supports key rotation" do
              let(:sdk_version) { 33 }

              it "behaves as it's direct update" do
                is_expected.to eq(certificate_from)
              end
            end
          end

          context "but the previous signer is the current one: a -> c" do
            let(:lineages_to) do
              [
                {
                  "installed data" => true,
                  "shared uid" => true,
                  "permission" => true,
                  "rollback" => false,
                  "auth" => true
                }.merge(certificate_from),
                {
                  "installed data" => true,
                  "shared uid" => true,
                  "permission" => true,
                  "rollback" => false,
                  "auth" => true
                }.merge(certificate_c)
              ]
            end

            let(:fingerprints_to) do
              [
                {
                  "min_sdk_version" => 24,
                  "max_sdk_version" => 32
                }.merge(certificate_from),
                {
                  "min_sdk_version" => 33,
                  "max_sdk_version" => 2_147_483_647
                }.merge(certificate_c)
              ]
            end

            context "if the device does not support key rotation" do
              let(:sdk_version) { 27 }

              it "behaves as it's direct update" do
                is_expected.to eq(certificate_from)
              end
            end

            context "if the device supports key rotation" do
              let(:sdk_version) { 33 }

              it "consumed key-rotation" do
                is_expected.to eq(certificate_c)
              end
            end
          end
        end
      end
    end

    context "if the current apk is rotated with a -> c" do
      let(:allow_rollback) { false }
      let(:lineages_from) do
        [
          {
            "installed data" => true,
            "shared uid" => true,
            "permission" => true,
            "rollback" => allow_rollback,
            "auth" => true
          }.merge(certificate_a),
          {
            "installed data" => true,
            "shared uid" => true,
            "permission" => true,
            "rollback" => false,
            "auth" => true
          }.merge(certificate_c)
        ]
      end

      context "if the device does not support v3" do
        let(:sdk_version) { 27 }
        let(:certificate_from) { lineages_from.first.slice("md5", "sha1", "sha256") }

        context "if the target apk is unsigned" do
          let(:lineages_to) { [] }
          let(:fingerprints_to) { [] }

          it { is_expected.to be_nil }
        end

        context "if the target apk is not rotated" do
          let(:lineages_to) { [] }

          context "and it's the same to the current one" do
            let(:fingerprints_to) do
              [
                {
                  "min_sdk_version" => 24,
                  "max_sdk_version" => 2_147_483_647
                }.merge(certificate_from)
              ]
            end

            it "behaves as it's direct update" do
              is_expected.to eq(certificate_from)
            end
          end

          context "and it's signed by certificate b" do
            let(:fingerprints_to) do
              [
                {
                  "min_sdk_version" => 24,
                  "max_sdk_version" => 2_147_483_647
                }.merge(certificate_b)
              ]
            end

            it { is_expected.to be_nil }
          end

          context "and it's rotated" do
            context "but the new signer is the current one: b -> a" do
              let(:lineages_to) do
                [
                  {
                    "installed data" => true,
                    "shared uid" => true,
                    "permission" => true,
                    "rollback" => false,
                    "auth" => true
                  }.merge(certificate_b),
                  {
                    "installed data" => true,
                    "shared uid" => true,
                    "permission" => true,
                    "rollback" => false,
                    "auth" => true
                  }.merge(certificate_from)
                ]
              end
              let(:fingerprints_to) do
                [
                  {
                    "min_sdk_version" => 24,
                    "max_sdk_version" => 32
                  }.merge(certificate_b),
                  {
                    "min_sdk_version" => 33,
                    "max_sdk_version" => 2_147_483_647,
                  }.merge(certificate_from)
                ]
              end

              it { is_expected.to be_nil }
            end

            context "the previous signer is the current one: a -> b" do
              let(:lineages_to) do
                [
                  {
                    "installed data" => true,
                    "shared uid" => true,
                    "permission" => true,
                    "rollback" => false,
                    "auth" => true,
                  }.merge(certificate_from),
                  {
                    "installed data" => true,
                    "shared uid" => true,
                    "permission" => true,
                    "rollback" => false,
                    "auth" => true
                  }.merge(certificate_b),
                ]
              end
              let(:fingerprints_to) do
                [
                  {
                    "min_sdk_version" => 24,
                    "max_sdk_version" => 32
                  }.merge(certificate_from),
                  {
                    "min_sdk_version" => 33,
                    "max_sdk_version" => 2_147_483_647
                  }.merge(certificate_b),
                ]
              end

              it "behaves as it's direct update" do
                is_expected.to eq(certificate_from)
              end
            end
          end
        end
      end

      context "if the device supports v3" do
        let(:sdk_version) { 33 }
        let(:certificate_from) { lineages_from.last.slice("md5", "sha1", "sha256") }

        context "if the target apk is unsigned" do
          let(:lineages_to) { [] }
          let(:fingerprints_to) { [] }

          it { is_expected.to be_nil }
        end

        context "if the target apk is not rotated" do
          let(:lineages_to) { [] }

          context "and it's the same to the current one" do
            let(:fingerprints_to) do
              [
                {
                  "min_sdk_version" => 24,
                  "max_sdk_version" => 2_147_483_647
                }.merge(certificate_from)
              ]
            end

            it "behaves as it's direct update" do
              is_expected.to eq(certificate_from)
            end
          end

          context "and it's signed by certificate b" do
            let(:fingerprints_to) do
              [
                {
                  "min_sdk_version" => 24,
                  "max_sdk_version" => 2_147_483_647
                }.merge(certificate_b)
              ]
            end

            it { is_expected.to be_nil }
          end

          context "and it's signed by the previous signer" do
            let(:previous_certificate) { lineages_from.first.slice("md5", "sha1", "sha256") }
            let(:fingerprints_to) do
              [
                {
                  "min_sdk_version" => 24,
                  "max_sdk_version" => 2_147_483_647
                }.merge(previous_certificate)
              ]
            end

            it { is_expected.to be_nil }

            context "if it has rollback capability" do
              let(:allow_rollback) { true }

              it "can rollback" do
                is_expected.to eq(previous_certificate)
              end
            end
          end

          context "and it's rotated" do
            context "but the new signer is the current one: b -> a" do
              let(:lineages_to) do
                [
                  {
                    "installed data" => true,
                    "shared uid" => true,
                    "permission" => true,
                    "rollback" => false,
                    "auth" => true
                  }.merge(certificate_b),
                  {
                    "installed data" => true,
                    "shared uid" => true,
                    "permission" => true,
                    "rollback" => false,
                    "auth" => true
                  }.merge(certificate_from)
                ]
              end
              let(:fingerprints_to) do
                [
                  {
                    "min_sdk_version" => 24,
                    "max_sdk_version" => 32
                  }.merge(certificate_b),
                  {
                    "min_sdk_version" => 33,
                    "max_sdk_version" => 2_147_483_647
                  }.merge(certificate_from)
                ]
              end

              it "behaves as it's direct update" do
                is_expected.to eq(certificate_from)
              end
            end

            context "the previous signer is the current one: a -> b" do
              let(:lineages_to) do
                [
                  {
                    "installed data" => true,
                    "shared uid" => true,
                    "permission" => true,
                    "rollback" => false,
                    "auth" => true
                  }.merge(certificate_from),
                  {
                    "installed data" => true,
                    "shared uid" => true,
                    "permission" => true,
                    "rollback" => false,
                    "auth" => true
                  }.merge(certificate_b),
                ]
              end
              let(:fingerprints_to) do
                [
                  {
                    "min_sdk_version" => 24,
                    "max_sdk_version" => 32,
                  }.merge(certificate_from),
                  {
                    "min_sdk_version" => 33,
                    "max_sdk_version" => 2_147_483_647
                  }.merge(certificate_b),
                ]
              end

              it "consumes key-rotation" do
                is_expected.to eq(certificate_b)
              end
            end
          end
        end
      end
    end
  end
end
