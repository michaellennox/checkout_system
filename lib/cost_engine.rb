class CostEngine
  def initialize(products)
    @products = products
  end

  def total_basket(order)
    order.reduce(0) do |sum, (item, num)|
      sum += cost_for(item, products) * num
    end
  end

  private

  attr_reader :products

  def cost_for(item)

  end
end
