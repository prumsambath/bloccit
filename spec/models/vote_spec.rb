require 'rails_helper'

describe Vote do
  describe "valdations" do
    describe "value validation" do
      it "only allows -1 or 1 as values" do
        v = Vote.new(value: 1)
        expect(v.valid?).to eq(true)

        v2 = Vote.new(value: -1)
        expect(v.valid?).to eq(true)

        v3 = Vote.new(value: 2)
        expect(v.valid?).to eq(false)
      end
    end
  end
end
