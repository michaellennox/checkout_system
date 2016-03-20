require 'byebug'

class CostEngine
  def initialize(promotional_rules, products: nil)
    @promotional_rules = promotional_rules
    @product_prices = products_with_prices(products)
  end

  def total_basket(order)
    promotional_rules.reduce(sum_without_discounts(order)) do |sum, rule|
      sum - rule.call(sum, order)
    end
  end

  private

  attr_reader :product_prices, :promotional_rules

  def sum_without_discounts(order)
    order.reduce(0) do |sum, (item, num)|
      sum += cost_for(item, num)
    end
  end

  def cost_for(item, num)
    product_prices[item] * num
  end

  def products_with_prices(products)
    products.map { |product| [product.code, product.price] }.to_h
  end
end
