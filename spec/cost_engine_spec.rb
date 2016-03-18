describe CostEngine do
  subject(:cost_engine) { described_class.new products }
  let(:item_001) { double :Item, code: "001", price: 900 }
  let(:item_002) { double :Item, code: "002", price: 300 }
  let(:products) { [item_001, item_002] }
  let(:order) { { "001" => 1, "002" => 1 } }

  describe '#total_basket' do
    it 'is expected to calculate the cost of a basket' do
      expect(cost_engine.total_basket(order)).to eq 1200
    end
  end
end
