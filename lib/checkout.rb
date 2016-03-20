require_relative 'cost_engine'

class Checkout
  def initialize(promotional_rules = nil, products: nil, cost_engine_klass: CostEngine)
    @products = products
    @cost_engine = cost_engine_klass.new(promotional_rules, products: products)
    @order = Hash.new(0)
  end

  def scan(item_code)
    fail "#{item_code} is not a valid item code" unless item_in_products?(item_code)
    @order[item_code] += 1
  end

  def total
    '£%.2f' % order_cost_in_pounds
  end

  private

  attr_reader :products, :cost_engine, :order

  def order_cost_in_pounds
    cost_engine.total_basket(order) / 100.0
  end

  def item_in_products?(item_code)
    products.map{ |product| product.code }.include?(item_code)
  end
end
