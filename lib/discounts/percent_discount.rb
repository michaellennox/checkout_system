class PercentDiscount
  def initialize(percent_discount, min_value)
    @percent_discount = percent_discount
    @min_value = min_value
  end

  def apply(current_total, order)
    total_enough_for_discount?(current_total) ? apply_discount(current_total) : 0
  end

  private

  attr_reader :percent_discount, :min_value

  def total_enough_for_discount?(current_total)
    current_total > min_value
  end

  def apply_discount(current_total)
    current_total * percent_discount / 100
  end
end
