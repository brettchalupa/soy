# frozen_string_literal: true

module Soy
  # Utility class for taking a path to a file and determining what its
  # capabilities are within Soy
  class File
    def initialize(file_path)
      @file_path = file_path
    end

    def read
      ::File.read(@file_path)
    end

    def rendered_name
      bare_name = @file_path.split("/").last.split(".").first
      "#{bare_name}.html"
    end

    def render_with_erb?
      @file_path =~ /.erb$/ || markdown? || html?
    end

    def markdown?
      @file_path =~ /.(md|markdown)/
    end

    def html?
      @file_path =~ /.html/
    end
  end
end
