# frozen_string_literal: true

RSpec.describe Soy do
  it "has a version number" do
    expect(Soy::VERSION).not_to be_nil
  end

  describe ".build" do
    let(:fixture_dir) { "spec/fixtures/site" }
    let(:build_dir) { "#{fixture_dir}/build" }

    before { FileUtils.rm_rf(build_dir) }

    it "makes the build dir" do
      described_class.build(fixture_dir)

      expect(Dir.exist?(build_dir)).to be(true)
    end

    it "generates HTML pages for the content rendered in the layout" do
      described_class.build(fixture_dir)

      index = File.read("#{build_dir}/index.html")
      expect(index).to match(%r{<title>Hello, world!</title>})
      expect(index).to match(%r{<h1>Hello from Soy</h1>})
    end

    context "with a nil dir" do
      it "defaults to the current dir"
    end
  end
end
