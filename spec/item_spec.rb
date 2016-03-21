require_relative '../lib/item'

describe Item do
  subject(:item) { described_class.new(code: '001', name: 'Lavender heart', price: 900) }

  describe '#price' do
    it 'is expected to return the price of the item' do
      expect(item.price).to eq 900
    end
  end

  describe '#code' do
    it 'is expected to return the code for the item' do
      expect(item.code).to eq '001'
    end
  end
end
