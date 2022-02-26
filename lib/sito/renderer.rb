# frozen_string_literal: true

module Sito
  # Takes IO objects and runs them through ERB
  class Renderer
    def initialize(template, layout = nil)
      @template = template
      @layout = layout
    end

    def render
      _render(@layout) do
        _render(@template)
      end
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
