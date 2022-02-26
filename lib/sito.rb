# frozen_string_literal: true

require_relative "sito/version"
require_relative "sito/renderer"

require "erb"
require "fileutils"

# Entry point into the library
module Sito
  class Error < StandardError; end

  def self.build(dir)
    dir ||= Dir.pwd
    FileUtils.mkdir_p("#{dir}/build")

    layout = File.read("#{dir}/views/layout.html.erb")
    files = Dir.glob("#{dir}/content/**/*.html.erb")

    files.each do |file|
      bare_name = file.split("/").last.split(".").first
      out = Sito::Renderer.new(File.read(file), layout).render
      File.write("#{dir}/build/#{bare_name}.html", out)
    end
  end
end
