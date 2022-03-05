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
      expect(output).to match(/version \(v\) - current version of the library/)
    end

    ["h", "-h", "--help"].each do |ali|
      it "supports the #{ali} alias" do
        output = run_cmd(ali)
        expect(output).to match(/version \(v\) - current version of the library/)
      end
    end
  end

  describe "soy new" do
    it "generates a new site from the template" do
      FileUtils.rm_rf("recipes")

      output = run_cmd("new recipes")

      expect(output).to match(/New Soy site created, view in: recipes/)

      expect(File.exist?("recipes/content/index.html.erb")).to be(true)
      expect(File.exist?("recipes/views/layout.html.erb")).to be(true)
      expect(File.read("recipes/.gitignore")).to match(/build/)

      FileUtils.rm_rf("recipes")
    end
  end

  describe "soy version" do
    it "outputs the version" do
      output = run_cmd("version")
      expect(output).to match(/#{Soy::VERSION}/)
    end

    ["v", "-v", "--version"].each do |ali|
      it "supports the #{ali} alias" do
        output = run_cmd(ali)
        expect(output).to match(/#{Soy::VERSION}/)
      end
    end
  end
end
