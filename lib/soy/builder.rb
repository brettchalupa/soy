# frozen_string_literal: true

require "fileutils"

module Soy
  # Builds the static site content
  class Builder
    def initialize(project_dir)
      @project_dir = project_dir
      @build_dir = "#{@project_dir}/build/"
    end

    def call
      @layout = File.read("#{@project_dir}/views/layout.html.erb")
      FileUtils.mkdir_p(@build_dir)
      process_dir("#{@project_dir}/content")
    end

    private

    def process_dir(dir)
      content = Dir.glob("#{dir}/*")

      content.each do |file|
        if file =~ /html.erb$/
          bare_name = file.split("/").last.split(".").first
          out = Soy::Renderer.new(File.read(file), @layout).render
          File.write("#{@build_dir}/#{bare_name}.html", out)
        else
          FileUtils.cp(file, @build_dir)
        end
      end
    end
  end
end
