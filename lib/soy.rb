# frozen_string_literal: true

require_relative "soy/renderer"
require_relative "soy/server"
require_relative "soy/version"

require "erb"
require "fileutils"

# Entry point into the library
module Soy
  class Error < StandardError; end

  def self.build(dir)
    dir ||= Dir.pwd
    FileUtils.mkdir_p("#{dir}/build")

    layout = File.read("#{dir}/views/layout.html.erb")
    files = Dir.glob("#{dir}/content/**/*.html.erb")

    files.each do |file|
      bare_name = file.split("/").last.split(".").first
      out = Soy::Renderer.new(File.read(file), layout).render
      File.write("#{dir}/build/#{bare_name}.html", out)
    end
  end
end
