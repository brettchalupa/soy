# frozen_string_literal: true

require "spec_helper"

RSpec.describe "CLI - sito version" do
  it "outputs the version" do
    output = `ruby -Ilib ./exe/sito version`
    expect(output).to match(/#{Sito::VERSION}/)
  end

  it "supports the v alias" do
    output = `ruby -Ilib ./exe/sito v`
    expect(output).to match(/#{Sito::VERSION}/)
  end
end
