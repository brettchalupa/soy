# frozen_string_literal: true

require_relative "soy/builder"
require_relative "soy/renderer"
require_relative "soy/server"
require_relative "soy/version"

require "erb"

# Entry point into the library
module Soy
  class Error < StandardError; end

  def self.build(dir)
    dir ||= Dir.pwd
    Builder.new(dir).call
  end
end
