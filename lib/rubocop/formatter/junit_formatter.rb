require "rubocop/formatter/clang_style_formatter"
require "rexml/document"
require "pathname"

module RuboCop
  module Formatter
    class JUnitFormatter < ClangStyleFormatter
      def initialize(output, options = {})
        super
        @failures = 0
      end

      def started(target_files)
        @document = REXML::Document.new
        @document << REXML::XMLDecl.new.tap do |declaration|
          declaration.encoding = "UTF-8"
        end

        @testsuite = @document.add_element("testsuite")
        @testsuite.add_attributes(
          "name" => "RuboCop",
          "tests" => target_files.size,
          "timestamp" => DateTime.now.new_offset(0)
        )
      end

      def file_started(file, options)
        @files ||= {}
        @files[file] = Time.now
      end

      def file_finished(file, offenses)
        time = Time.now - @files[file]
        @failures += 1 if offenses.any?

        file_smart_path = smart_path(file)

        testcase = @testsuite.add_element("testcase")
        testcase.add_attributes(
          "name" => file_smart_path,
          "file" => file_smart_path,
          "failures" => offenses.size,
          "time" => time.round(6)
        )

        offenses.each do |offense|
          failure = testcase.add_element("failure")
          failure.add_attributes(
            "message" => offense.message,
            "type" => offense.severity.to_s
          )

            text = sprintf(
              "%s:%d:%d: %s: %s\n",
              file_smart_path,
              offense.line,
              offense.real_column,
              offense.severity.code,
              offense.message
            )

          begin
            if valid_line?(offense)
              source_line = offense.location.source_line

              if offense.location.first_line == offense.location.last_line
                text << "#{source_line}\n"
              else
                text << "#{source_line} #{yellow(ELLIPSES)}\n"
              end

              text << "#{' ' * offense.highlighted_area.begin_pos}" \
                      "#{'^' * offense.highlighted_area.size}"
            end
          rescue IndexError
            # range is not on a valid line; perhaps the source file is empty
          end

          failure.add_text(text)
        end
      end

      def finished(inspected_files)
        @testsuite.add_attribute("failures", @failures)
        @document.write(output)
      end
    end
  end
end
