# frozen_string_literal: true

RSpec.describe Soy do
  it "has a version number" do
    expect(Soy::VERSION).not_to be_nil
  end

  describe ".new_site" do
    let(:site) { "new_site" }

    it "recursively copies the template dir into the passed in dir" do
      expect(FileUtils).to receive(:cp_r).with(%r{lib/soy/template}, site)

      expect do
        described_class.new_site("new_site")
      end.to output(/site created/).to_stdout
    end
  end
end
