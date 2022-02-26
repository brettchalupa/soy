# frozen_string_literal: true

require "spec_helper"

RSpec.describe "CLI - sito bogus" do
  it "outputs an error w/ help recommendation" do
    output = `ruby -Ilib ./exe/sito bogus`
    expect(output).to match(/`bogus` is not a command/)
    expect(output).to match(/Run `sito help` for list of commands/)
  end
end
