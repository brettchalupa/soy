# frozen_string_literal: true

require "spec_helper"

RSpec.describe Sito::Renderer do
  describe "#render" do
    it "renders the template in the layout" do
      template = "<h1>Neat Page</h1>"
      layout = "[Header] <%= yield %>"
      out = described_class.new(template, layout).render
      expect(out).to eql("[Header] <h1>Neat Page</h1>")
    end

    context "when layout is not specified" do
      it "defaults to nil" do
        template = "<h1>Neat Page</h1>"
        out = described_class.new(template).render
        expect(out).to eql("<h1>Neat Page</h1>")
      end
    end

    context "when layout is nil" do
      it "still renders the template" do
        template = "<h1>Neat Page</h1>"
        out = described_class.new(template, nil).render
        expect(out).to eql("<h1>Neat Page</h1>")
      end
    end

    context "when the template does not yield" do
      it "just renders the layout" do
        template = "<h1>Neat Page</h1>"
        layout = "[Header]"
        out = described_class.new(template, layout).render
        expect(out).to eql("[Header]")
      end
    end
  end
end