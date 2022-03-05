# frozen_string_literal: true

require "kramdown"
require "soy/page"

module Soy
  # Runs the template through ERB and generates HTML from it, within optional
  # layout.
  class Renderer
    # template, +Soy::File+ instance
    # layout, +Soy::File+ instance
    def initialize(template, layout)
      @template = template
      @layout = layout

      @page = Page.new
    end

    def render
      out = _render(@template)
      out = convert_template(out)
      out = _render(@layout) { out }
      out = out.gsub(/^\s+$/, "")
      out.gsub(/\A\n/, "")
    end

    def link_to(href, text=nil, args={})
      href = href.is_a?(Symbol) ? path_for(href) : href

      "<a href='#{href}'" +
        "class='#{args.fetch(:class, nil)}'>" +
        "#{block_given? ? yield : text }</a>"
    end

    def path_for(route, args={})
      path = Routes.path(route)

      args.each do |k, v|
        path = path.gsub(":#{k}", v)
      end

      path
    end

    private

    def _render(template)
      if template.nil?
        yield
      else
        ERB.new(template.read).result(binding)
      end
    end

    def convert_template(text)
      text = Kramdown::Document.new(text).to_html if @template.markdown?

      text
    end
  end
end
