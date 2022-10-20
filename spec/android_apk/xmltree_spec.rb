# frozen_string_literal: true

describe AndroidApk::Xmltree do
  describe "#read" do
    let(:apk_filepath) { File.join(FIXTURE_DIR, "other", "sample.apk") }

    it "returns non-nil if valid" do
      expect(AndroidApk::Xmltree.read(apk_filepath: apk_filepath, xml_filepath: "AndroidManifest.xml")).not_to be_nil
    end

    it "returns nil unless valid" do
      expect(AndroidApk::Xmltree.read(apk_filepath: apk_filepath, xml_filepath: "AndroidManifest_not_found.xml")).to be_nil
    end

    context "when an real adaptive icon file is given" do
      let(:apk_filepath) { File.join(FIXTURE_DIR, "resources", "apks-21", "adaptiveIconWithPng.apk") }

      it "returns if adaptive icon is true" do
        tree = AndroidApk::Xmltree.read(apk_filepath: apk_filepath, xml_filepath: "res/mipmap-anydpi-v26/ic_launcher.xml")
        expect(tree).not_to be_nil
        expect(tree).to be_valid
        expect(tree).to be_adaptive_icon
        expect(tree).not_to be_vector_drawable
      end
    end

    context "when an real vd icon file is given" do
      let(:apk_filepath) { File.join(FIXTURE_DIR, "resources", "apks-21", "vectorDrawableIconOnly.apk") }

      it "returns if vector drawable icon is true" do
        tree = AndroidApk::Xmltree.read(apk_filepath: apk_filepath, xml_filepath: "res/drawable/ic_launcher.xml")
        expect(tree).not_to be_nil
        expect(tree).to be_valid
        expect(tree).not_to be_adaptive_icon
        expect(tree).to be_vector_drawable
      end
    end
  end

  describe "#valid?" do
    let(:xmltree) { AndroidApk::Xmltree.new(content: content) }

    context "when content is nil" do
      let(:content) { nil }

      it { expect(xmltree).not_to be_valid }
    end

    context "when content is empty" do
      let(:content) { "" }

      it { expect(xmltree).not_to be_valid }
    end

    context "when content has many namespaces" do
      let(:content) do
        namespaces = ["N: android=http://schemas.android.com/apk/res/android"] * num_of_namespaces

        [
          *namespaces,
          "  E: manifest (line=2)",
          "    A: android:versionCode(0x0101021b)=(type 0x10)0x1"
        ].join("\n")
      end

      context "if # of namespaces is 1" do # the simplest case
        let(:num_of_namespaces) { 1 }

        it { expect(xmltree).to be_valid }
      end

      context "if # of namespaces is threshold - 1" do
        let(:num_of_namespaces) { 8 }

        it { expect(xmltree).to be_valid }
      end

      context "if # of namespaces is equal to threshold" do
        let(:num_of_namespaces) { 9 }

        it { expect(xmltree).to be_valid }
      end

      context "if # of namespaces is threshold + 1" do
        let(:num_of_namespaces) { 10 }

        it { expect(xmltree).not_to be_valid }
      end
    end

    context "when content has no root element" do
      let(:content) do
        [
          "N: android=http://schemas.android.com/apk/res/android",
          "  A: android:versionCode(0x0101021b)=(type 0x10)0x1"
        ].join("\n")
      end

      it { expect(xmltree).not_to be_valid }
    end
  end

  describe "#vector_drawable?" do
    let(:xmltree) { AndroidApk::Xmltree.new(content: content) }

    context "when the root element is a manifest" do
      let(:content) do
        [
          "N: android=http://schemas.android.com/apk/res/android",
          "  E: manifest (line=2)",
          "    A: android:versionCode(0x0101021b)=(type 0x10)0x1"
        ].join("\n")
      end

      it { expect(xmltree).not_to be_vector_drawable }
    end

    context "when the root element is an adaptive icon" do
      let(:content) do
        [
          "N: android=http://schemas.android.com/apk/res/android",
          "  E: adaptive-icon (line=2)",
          "    A: android:versionCode(0x0101021b)=(type 0x10)0x1"
        ].join("\n")
      end

      it { expect(xmltree).not_to be_vector_drawable }
    end

    context "when the root element is a vector" do
      let(:content) do
        [
          "N: android=http://schemas.android.com/apk/res/android",
          "  E: vector (line=2)",
          "    A: android:versionCode(0x0101021b)=(type 0x10)0x1"
        ].join("\n")
      end

      it { expect(xmltree).to be_vector_drawable }
    end
  end

  describe "#adaptive_icon?" do
    let(:xmltree) { AndroidApk::Xmltree.new(content: content) }

    context "when the root element is a manifest" do
      let(:content) do
        [
          "N: android=http://schemas.android.com/apk/res/android",
          "  E: manifest (line=2)",
          "    A: android:versionCode(0x0101021b)=(type 0x10)0x1"
        ].join("\n")
      end

      it { expect(xmltree).not_to be_adaptive_icon }
    end

    context "when the root element is an adaptive icon" do
      let(:content) do
        [
          "N: android=http://schemas.android.com/apk/res/android",
          "  E: adaptive-icon (line=2)",
          "    A: android:versionCode(0x0101021b)=(type 0x10)0x1"
        ].join("\n")
      end

      it { expect(xmltree).to be_adaptive_icon }
    end

    context "when the root element is a vector" do
      let(:content) do
        [
          "N: android=http://schemas.android.com/apk/res/android",
          "  E: vector (line=2)",
          "    A: android:versionCode(0x0101021b)=(type 0x10)0x1"
        ].join("\n")
      end

      it { expect(xmltree).not_to be_adaptive_icon }
    end
  end
end
