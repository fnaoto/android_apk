class AndroidApk
  module ResourceFinder
    class << self
      # @param apk_filepath [String] apk file path
      # @param default_icon_path [String, NilClass]
      # @return [Hash] keys are dpi human readable names, values are png file paths that are relative
      def resolve_icons_in_arsc(apk_filepath:, default_icon_path:)
        return Hash.new if default_icon_path.nil? || default_icon_path.empty?

        results = `aapt dump --values resources #{apk_filepath.shellescape} 2>&1`
        if $?.exitstatus != 0 or results.index("ERROR: dump failed")
          return Hash.new
        end

        lines = results.split("\n")

        value_index = lines.index { |line| line.index(default_icon_path) } or return Hash.new
        resource_name = lines[value_index - 1].split(":")[1] or return Hash.new # e.g. mipmap/ic_launcher

        start_index = lines.index { |line| line.index("spec resource ") && line.index(resource_name) }

        config_hash = {}

        lines = lines.drop(start_index + 1)

        # A target to find values is only one *type* block.
        #
        # type <number> configCount=<m> entryCount=<l> (N blocks)
        #   spec resource ... (l lines)
        #   config <config_name>: (m blocks)
        #     resource ... <resource_name>: ... (l blocks)
        #       ... "<file path>"

        # lines that start with "spec" are already rejected
        index = 0

        while index < lines.size do

          line = lines[index]
          index += 1

          break if line.index("type ")

          # drop until a config block will be found
          next unless (config = line.match(/config\s+(?'dpi'.+):/)&.named_captures&.dig("dpi"))

          while index < lines.size do
            line = lines[index]
            index += 1

            if line.index("config ")
              index -= 1
              break
            end

            # drop until a line contains <resource_name>
            next unless line.index(resource_name)

            # Next line contains the filepath and never contain a config block header
            line = lines[index]
            index += 1

            png_file_path = line.match(/"(?'path'.+)"/)&.named_captures&.dig("path") # never nil

            config_hash[config] = png_file_path
          end
        end

        config_hash
      end
    end
  end
end