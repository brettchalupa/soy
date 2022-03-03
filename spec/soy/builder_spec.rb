# frozen_string_literal: true

require "spec_helper"

RSpec.describe Soy::Builder do
  describe "#call" do
    it "renders html.erb as html into the output dir"
    it "copies non-html files into the output dir"
  end
end
