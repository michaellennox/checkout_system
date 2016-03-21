class PercentDiscount
  def initialize(percent_discount, min_value)
    @percent_discount = percent_discount
    @min_value = min_value
  end

  def apply(current_total, order)
    current_total > min_value ? current_total * percent_discount / 100 : 0
  end

  private

  attr_reader :percent_discount, :min_value
end
