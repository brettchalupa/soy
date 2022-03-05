# frozen_string_literal: true

require "spec_helper"

RSpec.describe Soy::Builder do
  subject(:builder) { described_class.new(fixture_dir) }

  let(:fixture_dir) { "spec/fixtures/site" }
  let(:build_dir) { "#{fixture_dir}/build" }

  before { FileUtils.rm_rf(build_dir) }

  describe "#call" do
    it "makes the build dir" do
      builder.call

      expect(Dir.exist?(build_dir)).to be(true)
    end

    it "generates HTML pages for the content rendered in the layout" do
      builder.call

      index = File.read("#{build_dir}/index.html")
      expect(index).to match(%r{<title>Hello, world!</title>})
      expect(index).to match(%r{<h1>Hello from Soy</h1>})
    end

    context "with a nil dir" do
      it "defaults to the current dir" do
        builder = described_class.new(nil)
        expect(builder.instance_variable_get(:@project_dir)).to eql(Dir.pwd)
      end
    end
  end
end
