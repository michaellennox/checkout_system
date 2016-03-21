require_relative '../../lib/discounts/percent_discount'

describe PercentDiscount do
  subject(:percent_discount) { described_class.new(15, 1000) }

  describe '#apply' do
    it 'is expected to apply a 15% discount on values over 1000' do
      expect(percent_discount.apply(1500, {})).to eq 225
    end

    it 'is expected to apply no discount on values below 1000' do
      expect(percent_discount.apply(500, {})).to eq 0
    end
  end
end
