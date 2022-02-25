# frozen_string_literal: true

require "spec_helper"

RSpec.describe "sito --version" do
  it "outputs the version" do
    output = `ruby -Ilib ./exe/sito --version`
    expect(output).to match(/#{Sito::VERSION}/)
  end
end
