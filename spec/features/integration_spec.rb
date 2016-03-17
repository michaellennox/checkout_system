require_relative '../../lib/checkout'

describe 'Integration Specs' do
  let(:products) do
    {
      001 => Item.new('Lavender heart', 925),
      002 => Item.new('Personalised cufflinks', 425),
      003 => Item.new('Kids T-shirt', 1995)
    }
  end
  subject(:checkout) { Checkout.new products: products }

  it 'Test to cover 10% discount for over £60' do
    checkout.scan 001
    checkout.scan 002
    checkout.scan 003

    expect(checkout.total).to eq '£66.78'
  end
end
