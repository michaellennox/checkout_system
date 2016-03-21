require_relative '../../lib/discounts/percent_discount'

describe PercentDiscount do
  subject(:percent_discount) { described_class.new(15, 1000) }

  describe '#apply' do
    it 'is expected to apply a the specified discount on values over the specified minimum' do
      expect(percent_discount.apply(1500, {})).to eq 225
    end

    it 'is expected to apply no discount on values below the specified minimum' do
      expect(percent_discount.apply(500, {})).to eq 0
    end
  end
end
