# frozen_string_literal: true

require "listen"
require "rack"
require "rack/common_logger"
require "rack/lint"
require "rack/server"
require "rack/show_exceptions"

module Soy
  # Container of data for a given page
  class Server
    def self.start(dir = Dir.pwd)
      new(dir).call
    end

    def initialize(dir)
      @dir = dir || Dir.pwd
      @relative_output_dir = "build"
      @output_dir = "#{@dir}/#{@relative_output_dir}"
      @builder = Builder.new(@dir)
    end

    def call
      @builder.call
      start_watcher
      start_server
    end

    private

    def start_watcher
      puts "Watching for changes in #{@dir}"
      listener = Listen.to(@dir, ignore: [/#{@relative_output_dir}/]) do |modified, added, removed|
        puts(modified: modified, added: added, removed: removed)
        @builder.call
      end
      listener.start
    end

    def start_server
      puts "Serving files from #{@output_dir}"
      Rack::Server.start(app: app, Port: 9292)
    end

    def app
      Rack::CommonLogger.new(
        Rack::ShowExceptions.new(
          Rack::Lint.new(
            Rack::Static.new(
              -> { [200, { "Content-Type" => "text/html" }, ["Hello from Soy!"]] },
              urls: [""],
              root: @output_dir,
              index: "index.html"
            )
          )
        )
      )
    end
  end
end
