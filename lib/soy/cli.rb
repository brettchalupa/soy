# frozen_string_literal: true

require "soy"

module Soy
  # Command-Line Interface entrance for Soy
  class Cli
    include Helpers

    # @param args - ARGV, array of arguments
    def initialize(args)
      @args = Array(args)
    end

    COMMANDS = {
      build: {
        aliases: ["b"],
        description: "Generate the site, supports passing path to site directory",
        examples: ["soy build", "soy build path/to/site"],
        run: ->(args) { Soy::Builder.new(args[1]).call }
      },
      help: {
        aliases: ["h", "-h", "--help"],
        description: "Generate the site, supports passing path to site directory",
        examples: ["soy build", "soy build path/to/site"],
        run: lambda do |_args|
          puts "Soy v#{Soy::VERSION}\n\n"
          puts "Available commands:\n"
          COMMANDS.each do |command, details|
            puts "\t#{command} - #{details[:description]}"
            puts "\t\taliases: #{details[:aliases].join(", ")}"
            puts "\t\texamples:\n\t\t\t#{details[:examples].join("\n\t\t\t")}"
          end
        end
      },
      new: {
        aliases: ["n"],
        description: "Create a site from the basic Soy template",
        examples: ["soy new site_name"],
        run: ->(args) { Soy.new_site(args[1]) }
      },
      server: {
        aliases: %w[s serve],
        description: "Start development server & rebuild site on changes," \
                     "supports passing path to site directory and an optional --port arg",
        examples: ["soy server", "soy server path/to/site", "soy server --port=4040"],
        run: lambda do |args|
          opts = {}
          OptionParser.new do |parser|
            parser.banner = "soy server option flags"
            parser.on("-p", "--port [PORT]", Integer, "HTTP to run the server at")
          end.parse!(args, into: opts)
          Soy::Server.start(args[1], port: opts[:port])
        end
      },
      version: {
        aliases: ["v", "-v", "--version"],
        description: "Output installed Soy version",
        examples: ["soy version"],
        run: ->(_args) { puts Soy::VERSION }
      }
    }.freeze

    def run
      first_arg = @args[0]

      return COMMANDS[:help][:run].call(@args) if first_arg.nil?

      command = COMMANDS.find do |key, details|
        first_arg == key.to_s || details.fetch(:aliases, []).include?(first_arg)
      end

      if command
        command[1].fetch(:run).call(@args)
      else
        puts "`#{first_arg}` is not a command"
        puts "Run `soy help` for list of commands"
      end
    end
  end
end
