describe CostEngine do
  let(:item_001) { double :Item, code: "001", price: 900 }
  let(:item_002) { double :Item, code: "002", price: 300 }
  let(:products) { [item_001, item_002] }
  let(:percent_discount) { double :PercentDiscount, apply: 0 }
  let(:promotional_rules) { [percent_discount] }

  subject(:cost_engine) { described_class.new(promotional_rules, products: products) }

  describe '#total_basket' do
    it 'is expected to calculate basket without any bonuses' do
      order = { "001" => 1, "002" => 1 }
      expect(cost_engine.total_basket(order)).to eq 1200
    end

    it 'is expected to be able to apply a given discount' do
      allow(percent_discount).to receive(:apply).and_return 270
      order = { "001" => 3 }
      expect(cost_engine.total_basket(order)).to eq 2430
    end
  end
end
