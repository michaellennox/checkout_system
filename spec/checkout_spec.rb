require_relative '../lib/checkout'

describe Checkout do
  let(:cost_engine_klass) { double :CostEngine_klass, new: cost_engine }
  let(:cost_engine) { double :CostEngine }
  let(:item) { double :Item, code: '001' }
  let(:products) { [item] }
  subject(:checkout) { described_class.new(products: products, cost_engine_klass: cost_engine_klass) }

  describe '#scan' do
    it 'is expected to raise an error if given a code that is not in products' do
      expect{ checkout.scan('002') }.to raise_error '002 is not a valid item code'
    end
  end

  describe '#total' do
    it 'is expected to return the cost of the basket calculated by CostEngine' do
      checkout.scan('001')
      checkout.scan('001')

      allow(cost_engine).to receive(:total_basket)
        .with({'001' => 2}).and_return(500)

      expect(checkout.total).to eq '£5.00'
    end
  end
end
