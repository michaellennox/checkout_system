class PercentDiscount
  def initialize(percent_discount:, threshold:)
    @percent_discount = percent_discount
    @threshold = threshold
  end

  def apply(current_total, order)
    should_discount_be_applied?(current_total) ? apply_discount(current_total) : 0
  end

  private

  attr_reader :percent_discount, :threshold

  def should_discount_be_applied?(current_total)
    current_total > threshold
  end

  def apply_discount(current_total)
    current_total * percent_discount / 100
  end
end
