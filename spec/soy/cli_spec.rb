# frozen_string_literal: true

require "spec_helper"

RSpec.describe Soy::Cli do
  subject(:cli) { described_class.new(args) }

  context "with an alias" do
    ["v", "-v", "--version"].each do |ali|
      let(:args) { [ali] }

      it "works as expected" do
        expect { cli.run }.to output(/#{Soy::VERSION}/).to_stdout
      end
    end
  end

  describe "#run" do
    describe "build" do
      let(:args) { ["build"] }
      let(:builder) { instance_double("Soy::Builder") }

      it "calls out to builder" do
        allow(Soy::Builder).to receive(:new).with(nil) { builder }
        expect(builder).to receive(:call)

        cli.run
      end

      context "when the dir is supplied" do
        let(:args) { %w[build demo] }

        it "passes it through" do
          allow(Soy::Builder).to receive(:new).with("demo") { builder }
          expect(builder).to receive(:call)

          cli.run
        end
      end
    end

    describe "help" do
      let(:args) { ["help"] }

      it "outputs info about the commands" do
        expect { cli.run }.to output(/build - Generate the site/).to_stdout
      end
    end

    describe "new" do
      let(:args) { %w[new demo] }

      it "outputs info about the commands" do
        expect(Soy).to receive(:new_site).with("demo")

        cli.run
      end
    end

    describe "server" do
      let(:args) { ["server"] }

      it "boots the server" do
        expect(Soy::Server).to receive(:start).with(nil, port: nil)

        cli.run
      end

      context "when the path is provided" do
        let(:args) { %w[server demo] }

        it "passes it to the server" do
          expect(Soy::Server).to receive(:start).with("demo", port: nil)

          cli.run
        end
      end

      context "when the port flag is provided" do
        let(:args) { ["server", "demo", "--port=8080"] }

        it "passes it to the server" do
          expect(Soy::Server).to receive(:start).with("demo", port: 8080)

          cli.run
        end
      end
    end

    describe "version" do
      let(:args) { ["version"] }

      it "outputs the version" do
        expect { cli.run }.to output(/#{Soy::VERSION}/).to_stdout
      end
    end

    context "when the args are empty" do
      let(:args) { [] }

      it "outputs help" do
        expect { cli.run }.to output(/build - Generate the site/).to_stdout
      end
    end

    context "when the command does not exist" do
      let(:args) { ["bogus"] }

      it "shows an error" do
        expect { cli.run }.to output(/`bogus` is not a command/).to_stdout
      end
    end
  end
end
