require_relative '../../lib/checkout'
require_relative '../../lib/item'
require_relative '../../lib/discounts/percent_discount'
require_relative '../../lib/discounts/item_discount'

describe 'Integration Specs' do
  let(:products) do
    [
      Item.new(code: '001', name: 'Lavender heart', price: 925),
      Item.new(code: '002', name: 'Personalised cufflinks', price: 4500),
      Item.new(code: '003', name: 'Kids T-shirt', price: 1995)
    ]
  end

  let(:ten_percent_discount) { PercentDiscount.new(percent_discount: 10, threshold: 6000) }
  let(:lavender_heart_discount) { ItemDiscount.new(item_code: "001", min_items: 2, discount: 75) }
  let(:promotional_rules) { [lavender_heart_discount, ten_percent_discount] }
  subject(:checkout) { Checkout.new(promotional_rules, products: products) }

  it 'A 10% discount is expected to be applied for orders over £60' do
    checkout.scan '001'
    checkout.scan '002'
    checkout.scan '003'

    expect(checkout.total).to eq '£66.78'
  end

  it 'A discount is meant to be applied when 2 lavender hearts are ordered' do
    checkout.scan '001'
    checkout.scan '003'
    checkout.scan '001'

    expect(checkout.total).to eq '£36.95'
  end

  it 'Multiple discounts should be applied together in the right order' do
    checkout.scan '001'
    checkout.scan '002'
    checkout.scan '001'
    checkout.scan '003'

    expect(checkout.total).to eq '£73.76'
  end
end
