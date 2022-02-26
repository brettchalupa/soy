# frozen_string_literal: true

require "spec_helper"

RSpec.describe "CLI" do
  def run_cmd(cmd)
    `ruby -Ilib ./exe/soy #{cmd}`
  end

  describe "soy" do
    it "outputs help" do
      output = run_cmd(nil)
      expect(output).to match(/Soy CLI/)
    end
  end

  describe "soy bogus" do
    it "outputs an error w/ help recommendation" do
      output = run_cmd("bogus")
      expect(output).to match(/`bogus` is not a command/)
      expect(output).to match(/Run `soy help` for list of commands/)
    end
  end

  describe "soy build" do
    let(:fixture_dir) { "spec/system/site" }
    let(:build_dir) { "#{fixture_dir}/build" }

    before { FileUtils.rm_rf(build_dir) }

    it "generates the site" do
      output = run_cmd("build #{fixture_dir}")
      expect(output).to match(/Building site/)
      expect(output).to match(/built in \d.\d+ seconds/)
      expect(File.exist?("#{build_dir}/index.html")).to be(true)
    end

    it "supports the b alias" do
      output = run_cmd("b #{fixture_dir}")
      expect(output).to match(/Building site/)
    end
  end

  describe "soy help" do
    it "outputs info about available commands" do
      output = run_cmd("help")
      expect(output).to match(/Soy CLI/)
      expect(output).to match(/Available commands:/)
      expect(output).to match(/version \(v\) - current version of the library/)
    end

    it "supports the h alias" do
      output = run_cmd("h")
      expect(output).to match(/version \(v\) - current version of the library/)
    end
  end

  describe "soy version" do
    it "outputs the version" do
      output = run_cmd("version")
      expect(output).to match(/#{Soy::VERSION}/)
    end

    it "supports the v alias" do
      output = run_cmd("v")
      expect(output).to match(/#{Soy::VERSION}/)
    end
  end
end
