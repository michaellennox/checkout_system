class CostEngine
  def initialize(products: nil)
    @product_prices = products_with_prices(products)
  end

  def total_basket(order)
    before_discount(order)
  end

  private

  attr_reader :product_prices

  def before_discount(order)
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
