# frozen_string_literal: true

require "spec_helper"

RSpec.describe Soy::Page do
  subject(:page) { described_class.new }

  describe "#set" do
    it "assigns attr readers for the passed in keys and values" do
      page.set(title: "Top 10 Dogs")
      expect(page.title).to eql("Top 10 Dogs")
    end

    it "only accepts Hash args" do
      expect { page.set(100) }.to raise_error(ArgumentError)
    end
  end
end
