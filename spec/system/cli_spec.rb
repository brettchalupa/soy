# frozen_string_literal: true

require "spec_helper"

RSpec.describe "CLI" do
  describe "soy" do
    it "outputs help" do
      output = run_cmd(nil)
      expect(output).to match(/Soy v/)
    end
  end

  describe "soy bogus" do
    it "outputs an error w/ help recommendation" do
      output = run_cmd("bogus")
      expect(output).to match(/`bogus` is not a command/)
      expect(output).to match(/Run `soy help` for list of commands/)
    end
  end

  describe "soy help" do
    it "outputs info about available commands" do
      output = run_cmd("help")
      expect(output).to match(/Soy v/)
      expect(output).to match(/Available commands:/)
      expect(output).to match(/version - Output installed Soy version/)
    end
  end

  describe "soy version" do
    it "outputs the version" do
      output = run_cmd("version")
      expect(output).to match(/#{Soy::VERSION}/)
    end
  end
end
