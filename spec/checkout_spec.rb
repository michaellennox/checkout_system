require_relative '../lib/checkout'

describe Checkout do
  let(:basket_klass) { double :Basket_klass, new: basket }
  let(:basket) { double :Basket }
  let(:item) { double :Item, code: '001' }
  let(:products) { [item] }
  subject(:checkout) { described_class.new(products: products, basket_klass: basket_klass) }

  describe '#scan' do
    it 'is expected to raise an error if given a code that is not in products' do
      expect{ checkout.scan('002') }.to raise_error '002 is not a valid item code'
    end
  end

  describe '#total' do
    it 'is expected to return the cost of the basket calculated by CostEngine' do
      checkout.scan('001')
      checkout.scan('001')

      allow(basket).to receive(:total)
        .with({'001' => 2}).and_return(500)

      expect(checkout.total).to eq '£5.00'
    end
  end
end
