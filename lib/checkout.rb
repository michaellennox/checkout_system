require_relative 'basket'

class Checkout
  def initialize(promotional_rules = nil, products: nil, basket_klass: Basket)
    @products = products
    @basket = basket_klass.new(promotional_rules, products: products)
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

  attr_reader :products, :basket, :order

  def order_cost_in_pounds
    (basket.total(order) / 100.0).round(2)
  end

  def item_in_products?(item_code)
    products.map{ |product| product.code }
      .include?(item_code)
  end
end
