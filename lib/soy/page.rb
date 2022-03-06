# frozen_string_literal: true

module Soy
  # Container of data for a given page
  class Page
    # Create reader and writers for the passed in hash keys
    def set(args)
      raise ArgumentError, "must set with a Hash" unless args.is_a?(Hash)

      args.each do |attr, attr_val|
        self.class.send(:define_method, "#{attr}=".to_sym) do |value|
          instance_variable_set("@#{attr}", value)
        end

        self.class.send(:define_method, attr.to_sym) do
          instance_variable_get("@#{attr}")
        end

        public_send("#{attr}=".to_sym, attr_val)
      end
    end

    def method_missing(_)
      nil
    end

    def respond_to_missing?
      true
    end
  end
end
