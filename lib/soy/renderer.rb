# frozen_string_literal: true

require "soy/page"

module Soy
  # Takes IO objects and runs them through ERB
  class Renderer
    def initialize(template, layout = nil)
      @template = template
      @layout = layout
      @page = Page.new
    end

    def render
      template = _render(@template)
      _render(@layout) { template }
    end

    private

    def _render(template)
      if template.nil?
        yield
      else
        ERB.new(template).result(binding)
      end
    end
  end
end
