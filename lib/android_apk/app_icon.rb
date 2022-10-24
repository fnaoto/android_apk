# frozen_string_literal: true

class AndroidApk
  class AppIcon
    # @param apk_filepath [String] a path to an apk file
    # @param dpi [Integer] density https://developer.android.com/training/multiscreen/screendensities
    # @param resource_path [String] a resource path in the apk
    def initialize(apk_filepath:, dpi:, resource_path:)
      @apk_filepath = apk_filepath
      @dpi = dpi
      @resource_path = resource_path
      @extname = File.extname(@resource_path).downcase
    end

    # @return [Boolean] returns true if the resource path indicates png file, otherwise false. this may contain false-positive.
    def png?
      @extname == ".png"
    end

    # @return [Boolean] returns true if the resource path indicates webp file, otherwise false. this may contain false-positive.
    def webp?
      @extname == ".webp"
    end

    # @return [Boolean] returns true if the resource path indicates xml file, otherwise false. this may contain false-positive.
    def xml?
      @extname == ".xml"
    end

    # @return [Hash] icon's metadata
    def metadata
      {
        dpi: @dpi,
        resource_path: @resource_path
      }
    end

    # Delegation for Zip#open and Tempfile handling through IO#open interface
    # @yield
    # @yieldparam [IO]
    # @yieldreturn
    def open
      f = Tempfile.new(["app_icon", @extname])

      begin
        f.binmode

        Zip::File.open(@apk_filepath) do |zip_file|
          entry = zip_file.find_entry(@resource_path)

          if entry.nil?
            next nil
          end

          f.write(zip_file.read(entry))
        end

        f.rewind
      rescue StandardError
        f.close
        raise
      end

      if block_given?
        begin
          yield(f)
        ensure
          f.close
        end
      else
        f
      end
    end
  end
end
