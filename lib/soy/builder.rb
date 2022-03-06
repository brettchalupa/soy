# frozen_string_literal: true

require "fileutils"

module Soy
  # Builds the static site content
  class Builder
    include Helpers

    def initialize(project_dir)
      @project_dir = project_dir || Dir.pwd
      @build_dir = "#{@project_dir}/build/"
    end

    def call
      puts "Building site..."
      time = elapsed do
        FileUtils.mkdir_p(@build_dir)
        process_dir("#{@project_dir}/content")
      end
      puts "Site successfully built in #{time} seconds"
    end

    private

    def process_dir(dir)
      Dir.glob("#{dir}/*").each do |file|
        process_file(file)
      end
    end

    def process_file(file)
      template = Soy::File.new(file)

      if template.render_with_erb?
        layout = Soy::File.new("#{@project_dir}/views/layout.html.erb")
        out = Soy::Renderer.new(template, layout).render
        ::File.write("#{@build_dir}/#{template.rendered_name}", out)
      else
        FileUtils.cp(file, @build_dir)
      end
    end
  end
end
