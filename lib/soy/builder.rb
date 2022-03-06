# frozen_string_literal: true

require "fileutils"

module Soy
  # Builds the static site content
  class Builder
    include Helpers

    def initialize(project_dir)
      @project_dir = project_dir || Dir.pwd
      @build_dir = "#{@project_dir}/build/"
      @content_dir = "#{@project_dir}/content/"
    end

    def call
      puts "Building site..."
      time = elapsed do
        FileUtils.rm_rf(@build_dir)
        FileUtils.mkdir_p(@build_dir)
        process_content
      end
      puts "Site successfully built in #{time} seconds"
    end

    private

    def process_content
      Dir.glob("#{@content_dir}**/*").each do |file|
        process_file(file)
      end
    end

    def process_file(file_path)
      file = Soy::File.new(file_path)

      dest = file_path.gsub(@content_dir, @build_dir).gsub(%r{/\w+(\.\w+)+$}, "/")

      if ::File.directory?(file_path)
        FileUtils.mkdir_p(file_path.gsub(@content_dir, @build_dir))
      elsif file.render_with_erb?
        layout = Soy::File.new("#{@project_dir}/views/layout.html.erb")
        out = Soy::Renderer.new(file, layout).render
        ::File.write("#{dest}#{file.rendered_name}", out)
      else
        FileUtils.cp(file_path, dest)
      end
    end
  end
end
