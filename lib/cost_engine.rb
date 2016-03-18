class CostEngine
  def initialize(products)
    @product_prices = products_with_prices(products)
  end

  def total_basket(order)
    order.reduce(0) do |sum, (item, num)|
      sum += cost_for(item) * num
    end
  end

  private

  attr_reader :product_prices

  def cost_for(item)
    product_prices[item]
  end

  def products_with_prices(products)
    products.map { |product| [product.code, product.price] }.to_h
  end
end
