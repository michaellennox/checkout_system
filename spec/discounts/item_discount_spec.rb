require_relative '../../lib/discounts/item_discount'

describe ItemDiscount do
  subject(:item_discount) { described_class.new(item_code: "ITEM", min_items: 3, discount: 75) }

  describe '#apply' do
    it 'is expected to apply the discount on orders which contain more than the number of items' do
      expect(item_discount.apply(5000, { "ITEM" => 4 })).to eq 300
    end

    it 'is expected to apply no discount on orders which contain less than the number of items' do
      expect(item_discount.apply(1000, { "ITEM" => 2 })).to eq 0
    end
  end
end
