# frozen_string_literal: true

module Soy
  class Routes
    class << self
      def load(dir)
        @@routes ||= YAML.load(::File.read("#{dir}/routes.yml"))
      end

      def path(route)
        @@routes.fetch(route.to_s)
      end
    end
  end
end
