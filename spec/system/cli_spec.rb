# frozen_string_literal: true

require "spec_helper"

RSpec.describe "CLI" do
  def run_cmd(cmd)
    `ruby -Ilib ./exe/sito #{cmd}`
  end

  describe "sito" do
    it "outputs help" do
      output = run_cmd(nil)
      expect(output).to match(/Sito CLI/)
    end
  end

  describe "sito bogus" do
    it "outputs an error w/ help recommendation" do
      output = run_cmd("bogus")
      expect(output).to match(/`bogus` is not a command/)
      expect(output).to match(/Run `sito help` for list of commands/)
    end
  end

  describe "sito help" do
    it "outputs info about available commands" do
      output = run_cmd("help")
      expect(output).to match(/Sito CLI/)
      expect(output).to match(/Available commands:/)
      expect(output).to match(/version - current version of the library/)
    end

    it "supports the h alias" do
      output = run_cmd("h")
      expect(output).to match(/version - current version of the library/)
    end
  end

  describe "sito version" do
    it "outputs the version" do
      output = run_cmd("version")
      expect(output).to match(/#{Sito::VERSION}/)
    end

    it "supports the v alias" do
      output = run_cmd("v")
      expect(output).to match(/#{Sito::VERSION}/)
    end
  end
end
