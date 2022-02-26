# frozen_string_literal: true

require "spec_helper"

RSpec.describe "CLI" do
  def run_cmd(cmd)
    `ruby -Ilib ./exe/sito #{cmd}`
  end

  describe "sito bogus" do
    it "outputs an error w/ help recommendation" do
      output = run_cmd("bogus")
      expect(output).to match(/`bogus` is not a command/)
      expect(output).to match(/Run `sito help` for list of commands/)
    end
  end

  describe "sito version" do
    let(:output) { run_cmd("version") }

    it "outputs the version" do
      expect(output).to match(/#{Sito::VERSION}/)
    end

    it "supports the v alias" do
      expect(output).to match(/#{Sito::VERSION}/)
    end
  end
end
