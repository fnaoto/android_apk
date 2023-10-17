# frozen_string_literal: true

class AndroidApk
  class Xmltree
    class << self
      # @return [Xmltree,NilClass] If the tree is valid then returns non-nil tree, otherwise nil.
      def read(apk_filepath:, xml_filepath:)
        content = dump_xmltree(apk_filepath: apk_filepath, xml_filepath: xml_filepath)
        tree = ::AndroidApk::Xmltree.new(content: content)
        return tree if tree.valid?
      end

      private def dump_xmltree(apk_filepath:, xml_filepath:)
        stdout, _, status = Open3.capture3("aapt", "dump", "xmltree", apk_filepath, xml_filepath)
        stdout if status.success?
      end
    end

    def initialize(content:)
      @root_element = nil

      line_num = 1
      content&.split("\n") do |line|
        line.strip!

        if line.start_with?("E: ")
          @root_element = line
          break
        elsif line.start_with?("N: ")
          line_num += 1
          break if line_num > 10 # experimental value
        else
          break
        end
      end
    end

    def vector_drawable?
      @root_element&.start_with?("E: vector ")
    end

    def adaptive_icon?
      @root_element&.start_with?("E: adaptive-icon ")
    end

    def valid?
      @root_element != nil
    end
  end
end
