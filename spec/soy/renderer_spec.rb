# frozen_string_literal: true

require "spec_helper"

RSpec.describe Soy::Renderer do
  def file_double(content, markdown: false)
    instance_double("Soy::File", read: content, markdown?: markdown)
  end

  describe "#render" do
    it "renders the template in the layout" do
      template = file_double("<h1>Neat Page</h1>")
      layout = file_double("[Header] <%= yield %>")
      out = described_class.new(template, layout).render
      expect(out).to eql("[Header] <h1>Neat Page</h1>")
    end

    it "supports setting template details that render in the layout" do
      template = file_double("<% @page.set(title: 'Neat Page') %> <h1><%= @page.title %></h1>")
      layout = file_double("<title><%= @page.title %></title><%= yield %>")
      out = described_class.new(template, layout).render
      expect(out).to eql("<title>Neat Page</title> <h1>Neat Page</h1>")
    end

    it "strips lines with just whitespace" do
      template = file_double("\n\n  <% 'hi' %>\n hi\n")
      out = described_class.new(template, nil).render
      expect(out).to eql(" hi\n")
    end

    context "when layout is nil" do
      it "still renders the template" do
        template = file_double("<h1>Neat Page</h1>")
        out = described_class.new(template, nil).render
        expect(out).to eql("<h1>Neat Page</h1>")
      end
    end

    context "when the template does not yield" do
      it "just renders the layout" do
        template = file_double("<h1>Neat Page</h1>")
        layout = file_double("[Header]")
        out = described_class.new(template, layout).render
        expect(out).to eql("[Header]")
      end
    end

    context "when the template is a markdown file" do
      it "converts the markdown to HTML through ERB" do
        template = file_double("<% @title = 'Neat Page' %>\n# <%= @title %>\n\nSo much to say!\n", markdown: true)

        out = described_class.new(template, nil).render
        expect(out).to eql(
          <<~HTML
            <h1 id="neat-page">Neat Page</h1>

            <p>So much to say!</p>
          HTML
        )
      end
    end
  end
end
