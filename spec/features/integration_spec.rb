require_relative '../../lib/checkout'
require_relative '../../lib/item'

describe 'Integration Specs' do
  let(:products) do
    [
      Item.new('001', 'Lavender heart', 925),
      Item.new('002', 'Personalised cufflinks', 4500),
      Item.new('003', 'Kids T-shirt', 1995)
    ]
  end

  let(:ten_percent_discount) do
    Proc.new { |current_sum, order| current_sum > 6000 ? current_sum * 0.1 : 0 }
  end

  let(:lavender_heart_discount) do
    Proc.new { |current_sum, order| order["001"] >= 2 ? order["001"] * 75 : 0 }
  end

  let(:promotional_rules) { [lavender_heart_discount, ten_percent_discount] }
  subject(:checkout) { Checkout.new(promotional_rules, products: products) }

  it 'is expected to apply a 10% discount for over £60' do
    checkout.scan '001'
    checkout.scan '002'
    checkout.scan '003'

    expect(checkout.total).to eq '£66.78'
  end

  it 'is expected to apply a price drop when given 2 lavender hearts in order' do
    checkout.scan '001'
    checkout.scan '003'
    checkout.scan '001'

    expect(checkout.total).to eq '£36.95'
  end
end
