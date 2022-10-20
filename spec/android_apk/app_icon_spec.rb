# frozen_string_literal: true

describe AndroidApk::AppIcon do
  describe "#png?" do
    let(:app_icon) { AndroidApk::AppIcon.new(apk_filepath: "apk_filepath", dpi: 300, resource_path: resource_path) }

    context "when the path ends with .png" do
      let(:resource_path) { "res/ic.png" }

      it { expect(app_icon).to be_png }
    end

    context "when the path ends with png but not .png" do
      let(:resource_path) { "res/icpng" }

      it { expect(app_icon).not_to be_png }
    end

    context "when the path ends with .webp" do
      let(:resource_path) { "res/ic.webp" }

      it { expect(app_icon).not_to be_png }
    end

    context "when the path ends with .xml" do
      let(:resource_path) { "res/ic.xml" }

      it { expect(app_icon).not_to be_png }
    end
  end

  describe "#webp?" do
    let(:app_icon) { AndroidApk::AppIcon.new(apk_filepath: "apk_filepath", dpi: 300, resource_path: resource_path) }

    context "when the path ends with .png" do
      let(:resource_path) { "res/ic.png" }

      it { expect(app_icon).not_to be_webp }
    end

    context "when the path ends with .webp" do
      let(:resource_path) { "res/ic.webp" }

      it { expect(app_icon).to be_webp }
    end

    context "when the path ends with webp but not .webp" do
      let(:resource_path) { "res/icwebp" }

      it { expect(app_icon).not_to be_webp }
    end

    context "when the path ends with .xml" do
      let(:resource_path) { "res/ic.xml" }

      it { expect(app_icon).not_to be_webp }
    end
  end

  describe "#xml?" do
    let(:app_icon) { AndroidApk::AppIcon.new(apk_filepath: "apk_filepath", dpi: 300, resource_path: resource_path) }

    context "when the path ends with .png" do
      let(:resource_path) { "res/ic.png" }

      it { expect(app_icon).not_to be_xml }
    end

    context "when the path ends with .webp" do
      let(:resource_path) { "res/ic.webp" }

      it { expect(app_icon).not_to be_xml }
    end

    context "when the path ends with .xml" do
      let(:resource_path) { "res/ic.xml" }

      it { expect(app_icon).to be_xml }
    end

    context "when the path ends with xml but not .xml" do
      let(:resource_path) { "res/icxml" }

      it { expect(app_icon).not_to be_xml }
    end
  end

  describe "#open" do
    let(:apk_filepath) { File.join(FIXTURE_DIR, "new-resources", "apks-21", "adaptiveIconWithPng.apk") }
    let(:app_icon) { AndroidApk::AppIcon.new(apk_filepath: apk_filepath, dpi: 100_000, resource_path: "res/uF.xml") }

    it "returns not-yet-closed file object" do
      f = app_icon.open
      expect(File.exist?(f)).to be_truthy
      expect(f.size).to eq(448)
    ensure
      f.close
    end

    context "when block is given" do
      it "returns eval-block's value" do
        value = app_icon.open do |f|
          expect(File.exist?(f)).to be_truthy
          expect(f.size).to eq(448)
          "hello"
        end

        expect(value).to eq("hello")
      end
    end
  end
end
