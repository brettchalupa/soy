# frozen_string_literal: true

require_relative "soy/builder"
require_relative "soy/file"
require_relative "soy/renderer"
require_relative "soy/routes"
require_relative "soy/server"
require_relative "soy/version"

require "erb"

# Entry point into the library
module Soy
  class Error < StandardError; end

  def self.new_site(name)
    FileUtils.cp_r("#{__dir__}/soy/template/", name)
    puts "New Soy site created, view in: #{name}"
  end
end
