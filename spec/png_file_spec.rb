# frozen_string_literal: true

require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "png file" do
  subject(:available_png_icon) { AndroidApk.analyze(apk_filepath).available_png_icon }

  let(:comparator) {
    MiniMagick::Tool::Compare.new(whiny: false).tap do |c|
      c.metric('AE')
    end
  }

  Dir.glob("#{FIXTURE_DIR}/resource/*.apk").each do |apk_name|
    context "#{apk_name}" do
      let(:apk_filepath) { apk_name }
      let(:correct_icon_filepath) { File.join(FIXTURE_DIR, "oracle", "#{File.basename(apk_name)}.png") }

      let(:temp_dir) { Dir.mktmpdir }
      let(:generated_icon_filepath) { File.join(temp_dir, "#{File.basename(apk_name)}.png") }

      before do
        generated_icon_filepath
      end

      after do
        FileUtils.remove_entry(temp_dir)
      end

      should_contain_no_png = apk_name.start_with?("no_icon") ||
        apk_name.start_with?("misconfigured_adaptive_icon") ||
        %w[vd_icon-assembleRsa-v1-true-v2-true-min-21.apk vd_icon-assembleRsa-v1-true-v2-true-min-26.apk].include?(apk_name) # 14 must contain at least one png file

      if should_contain_no_png
        it { is_expected.to be_nil }
      else
        it "no diff is expected" do
          File.open(generated_icon_filepath, 'wb') do |f|
            f.write(available_png_icon.read)
          end

          comparator << generated_icon_filepath
          comparator << correct_icon_filepath
          comparator << File.join(temp_dir, "diff")

          comparator.call do |_, dist, _|
            expect(dist.to_i).to be_zero
          end
        end
      end
    end
  end
end