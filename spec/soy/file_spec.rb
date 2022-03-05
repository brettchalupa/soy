# frozen_string_literal: true

require "spec_helper"

RSpec.describe Soy::File do
  describe "#read" do
    it "reads the file from disk" do
      path = "path/to/file.html.erb"
      allow(File).to receive(:read).with(path) { "content" }

      expect(described_class.new(path).read).to eql("content")
    end
  end

  describe "#rendered_name" do
    it "strips away extraneous file types and outputs as HTML" do
      path = "path/to/file.html.erb"

      expect(described_class.new(path).rendered_name).to eql("file.html")
    end
  end

  describe "#render_with_erb?" do
    it "returns true for files that end with erb" do
      expect(described_class.new("file.html.erb")).to be_render_with_erb
      expect(described_class.new("file.md.erb")).to be_render_with_erb
      expect(described_class.new("file.css.erb")).to be_render_with_erb
    end

    it "returns false for files that don't end in erb" do
      expect(described_class.new("file.png")).to_not be_render_with_erb
      expect(described_class.new("file.css")).to_not be_render_with_erb
    end

    it "always returns true markdown and HTML files for .erb-less extension support" do
      expect(described_class.new("file.html")).to be_render_with_erb
      expect(described_class.new("file.md")).to be_render_with_erb
      expect(described_class.new("file.markdown")).to be_render_with_erb
    end
  end

  describe "#markdown?" do
    it "returns true for md" do
      expect(described_class.new("file.md")).to be_markdown
    end

    it "returns true for markdown" do
      expect(described_class.new("file.markdown")).to be_markdown
    end

    it "supports nested extensions" do
      expect(described_class.new("file.markdown.erb")).to be_markdown
    end

    it "returns false for anything else" do
      expect(described_class.new("file.png")).to_not be_markdown
    end
  end

  describe "#html?" do
    it "returns true for html" do
      expect(described_class.new("file.html")).to be_html
    end

    it "supports nested extensions" do
      expect(described_class.new("file.html.erb")).to be_html
    end

    it "returns false for anything else" do
      expect(described_class.new("file.png")).to_not be_html
    end
  end
end
