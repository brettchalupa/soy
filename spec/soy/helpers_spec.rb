# frozen_string_literal: true

RSpec.describe Soy::Helpers do
  subject(:instance) { Class.new }

  before { instance.extend(described_class) }

  describe "#elapsed" do
    it "returns the time it takes to run the block" do
      elapsed = instance.elapsed do
        sleep 0.005
        100 * 5
      end

      expect(elapsed.to_f).to be > 0.005
    end
  end
end
