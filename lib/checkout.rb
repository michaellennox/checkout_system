require 'byebug'

class Checkout
  def initialize(products: nil)
    @products = products
    @order = Hash.new(0)
  end

  def scan(item_code)
    fail "#{item_code} is not a valid item code" unless item_in_products?(item_code)
    @order[item_code] += 1
  end

  private

  attr_reader :products

  def item_in_products?(item_code)
    products.map{ |product| product.code }.include?(item_code)
  end
end
