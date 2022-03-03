# frozen_string_literal: true

require "rack"
require "rack/server"

module Soy
  # Container of data for a given page
  class Server
    def self.start(dir = Dir.pwd)
      dir ||= Dir.pwd
      output_dir = "#{dir}/build"
      puts "Serving files from #{output_dir}"
      Rack::Server.start(
        app: Rack::Static.new(new, urls: [""], root: output_dir, index: "index.html"),
        Port: 9292 # TODO: configurable port
      )
    end

    def call(_)
      [200, { "Content-Type" => "text/html" }, ["Hello from Soy!"]]
    end
  end
end
