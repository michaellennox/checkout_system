class Item
  attr_reader :code, :price
  
  def initialize(code, name, price)
    @code = code
    @name = name
    @price = price
  end
end
