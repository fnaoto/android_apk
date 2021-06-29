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

        start_index = lines.index { |line| line.lstrip.start_with?("spec resource ") && line.index(resource_name) }

        config_hash = {}

        iterator = lines.drop(start_index + 1).map(&:lstrip).reject { |line| line.start_with?("spec ") || line.empty? }

        # A target to find values is only one *type* block.
        #
        # type <number> configCount=<m> entryCount=<l> (N blocks)
        #   spec resource ... (l lines)
        #   config <config_name>: (m blocks)
        #     resource ... <resource_name>: ... (l blocks)
        #       ... "<file path>"

        # lines that start with "spec" are already rejected
        while iterator[0]&.start_with?("type ") == false do
          line, *iterator = iterator

          # drop until a config block will be found
          next unless (config = line.match(/config (.+):/)[1])

          while iterator[0]&.start_with?("config ") == false do
            line, *iterator = iterator

            # drop until a line contains <resource_name>
            next unless line.index(resource_name)

            # Next line contains the filepath and never contain a config block header
            line, *iterator = iterator

            png_file_path = line.match(/"(.+)"/)[1] # never nil

            config_hash[config] = png_file_path
          end
        end

        config_hash
      end
    end
  end
end