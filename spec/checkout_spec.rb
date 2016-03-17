require_relative '../lib/checkout'

describe Checkout do
  let(:item) { double :Item, code: '001' }
  let(:products) { [item] }
  subject(:checkout) { described_class.new products: products }

  describe '#scan' do
    it 'is expected to raise an error if given a code that is not in products' do
      expect{ checkout.scan('002') }.to raise_error '002 is not a valid item code'
    end
  end
end
