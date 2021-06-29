# frozen_string_literal: true

require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))

describe AndroidApk::ResourceFinder do
  describe "#resolve_icons_in_arsc" do
    subject { AndroidApk::ResourceFinder.resolve_icons_in_arsc(apk_filepath: apk_filepath, default_icon_path: default_icon_path) }

    context "sample.apk" do
      let(:apk_filepath) { File.join(FIXTURE_DIR, "other", "sample.apk") }
      let(:default_icon_path) { "res/drawable-mdpi/ic_launcher.png" }

      it do
        is_expected.to eq(
                         "hdpi-v4" => "res/drawable-hdpi/ic_launcher.png",
                         "mdpi-v4" => "res/drawable-mdpi/ic_launcher.png",
                         "xhdpi-v4" => "res/drawable-xhdpi/ic_launcher.png"
                       )
      end
    end

    context "sample with space.apk" do
      let(:apk_filepath) { File.join(FIXTURE_DIR, "other", "sample with space.apk") }
      let(:default_icon_path) { "res/drawable-mdpi/ic_launcher.png" }

      it do
        is_expected.to eq(
                         "hdpi-v4" => "res/drawable-hdpi/ic_launcher.png",
                         "mdpi-v4" => "res/drawable-mdpi/ic_launcher.png",
                         "xhdpi-v4" => "res/drawable-xhdpi/ic_launcher.png"
                       )
      end
    end

    context "resources" do
      let(:apk_filepath) { File.join(FIXTURE_DIR, "resource", apk_name) }

      context "png only icon" do
        let(:apk_name) { "png_icon-assembleRsa-v1-true-v2-true-min-21.apk" }
        let(:default_icon_path) { "res/mipmap-mdpi-v4/ic_launcher.png" }

        it do
          is_expected.to eq(
                           "hdpi" => "res/mipmap-hdpi-v4/ic_launcher.png",
                           "mdpi" => "res/mipmap-mdpi-v4/ic_launcher.png",
                           "xhdpi" => "res/mipmap-xhdpi-v4/ic_launcher.png",
                           "xxhdpi" => "res/mipmap-xxhdpi-v4/ic_launcher.png",
                           "xxxhdpi" => "res/mipmap-xxxhdpi-v4/ic_launcher.png"
                         )
        end
      end

      context "png only icon in drawable directory" do
        let(:apk_name) { "png_icon_in_drawable_only-assembleRsa-v1-true-v2-true-min-21.apk" }
        let(:default_icon_path) { "res/drawable/ic_launcher.png" }

        it do
          is_expected.to include(
                           "(default)" => "res/drawable/ic_launcher.png"
                         )
        end
      end

      context "no icon" do
        let(:apk_name) { "no_icon-assembleRsa-v1-true-v2-true-min-21.apk" }
        let(:default_icon_path) { "" }

        it { is_expected.to eq(Hash.new) }
      end

      context "adaptive icon" do
        let(:apk_name) { "adaptive_icon-assembleRsa-v1-true-v2-true-min-21.apk" }
        let(:default_icon_path) { "res/mipmap-anydpi-v26/ic_launcher.xml" }

        it do
          is_expected.to eq(
                           "anydpi-v26" => "res/mipmap-anydpi-v26/ic_launcher.xml",
                           "hdpi" => "res/mipmap-hdpi-v4/ic_launcher.png",
                           "mdpi" => "res/mipmap-mdpi-v4/ic_launcher.png",
                           "xhdpi" => "res/mipmap-xhdpi-v4/ic_launcher.png",
                           "xxhdpi" => "res/mipmap-xxhdpi-v4/ic_launcher.png",
                           "xxxhdpi" => "res/mipmap-xxxhdpi-v4/ic_launcher.png"
                         )
        end
      end

      context "misconfigured_adaptive_icon" do
        let(:apk_name) { "misconfigured_adaptive_icon-assembleRsa-v1-true-v2-true-min-21.apk" }
        let(:default_icon_path) { "res/mipmap-anydpi-v26/ic_launcher.xml" }

        it do
          is_expected.to include(
                           "anydpi-v26" => "res/mipmap-anydpi-v26/ic_launcher.xml"
                         )
        end
      end

      context "vector drawable and png" do
        let(:default_icon_path) { "res/drawable-mdpi-v4/ic_launcher.png" }

        context "min sdk 14" do
          let(:apk_name) { "vd_and_png_icon-assembleRsa-v1-true-v2-true-min-14.apk" }

          it do
            is_expected.to eq(
                             "anydpi-v21" => "res/drawable-anydpi-v21/ic_launcher.xml",
                             "hdpi" => "res/drawable-hdpi-v4/ic_launcher.png",
                             "mdpi" => "res/drawable-mdpi-v4/ic_launcher.png",
                             "ldpi" => "res/drawable-ldpi-v4/ic_launcher.png",
                             "xhdpi" => "res/drawable-xhdpi-v4/ic_launcher.png",
                             "xxhdpi" => "res/drawable-xxhdpi-v4/ic_launcher.png",
                             "xxxhdpi" => "res/drawable-xxxhdpi-v4/ic_launcher.png"
                           )
          end
        end

        context "min sdk 21" do
          let(:apk_name) { "vd_and_png_icon-assembleRsa-v1-true-v2-true-min-21.apk" }

          it do
            is_expected.to eq(
                             "(default)" => "res/drawable/ic_launcher.xml",
                             "hdpi" => "res/drawable-hdpi-v4/ic_launcher.png",
                             "mdpi" => "res/drawable-mdpi-v4/ic_launcher.png",
                             "xhdpi" => "res/drawable-xhdpi-v4/ic_launcher.png",
                             "xxhdpi" => "res/drawable-xxhdpi-v4/ic_launcher.png",
                             "xxxhdpi" => "res/drawable-xxxhdpi-v4/ic_launcher.png"
                           )
          end
        end
      end

      context "vector drawable only" do
        let(:apk_name) { "vd_icon-assembleRsa-v1-true-v2-true-min-21.apk" }
        let(:default_icon_path) { "res/drawable/ic_launcher.xml" }

        it do
          is_expected.to eq(
                           "(default)" => "res/drawable/ic_launcher.xml"
                         )
        end
      end
    end
  end
end
