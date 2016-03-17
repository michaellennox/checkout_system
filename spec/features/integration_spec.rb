require_relative '../../lib/checkout'

describe 'Integration Specs' do
  let(:products) do
    [
      Item.new('001', 'Lavender heart', 925),
      Item.new('002', 'Personalised cufflinks', 425),
      Item.new('003', 'Kids T-shirt', 1995)
    ]
  end
  subject(:checkout) { Checkout.new products: products }

  it 'Test to cover 10% discount for over £60' do
    checkout.scan '001'
    checkout.scan '002'
    checkout.scan '003'

    expect(checkout.total).to eq '£66.78'
  end
end
