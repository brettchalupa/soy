# frozen_string_literal: true

require "spec_helper"

RSpec.describe "CLI" do
  describe "sito bogus" do
    it "outputs an error w/ help recommendation" do
      output = `ruby -Ilib ./exe/sito bogus`
      expect(output).to match(/`bogus` is not a command/)
      expect(output).to match(/Run `sito help` for list of commands/)
    end
  end

  describe "sito version" do
    it "outputs the version" do
      output = `ruby -Ilib ./exe/sito version`
      expect(output).to match(/#{Sito::VERSION}/)
    end

    it "supports the v alias" do
      output = `ruby -Ilib ./exe/sito v`
      expect(output).to match(/#{Sito::VERSION}/)
    end
  end
end
