class Checkout
  def initialize(products: nil, cost_engine: nil)
    @products = products
    @cost_engine = cost_engine
    @order = Hash.new(0)
  end

  def scan(item_code)
    fail "#{item_code} is not a valid item code" unless item_in_products?(item_code)
    @order[item_code] += 1
  end

  def total
    "£#{'%.2f' % (cost_engine.calculate_basket(products, order) / 100)}"
  end

  private

  attr_reader :products, :cost_engine, :order

  def item_in_products?(item_code)
    products.map{ |product| product.code }.include?(item_code)
  end
end
