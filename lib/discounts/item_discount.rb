class ItemDiscount
  def initialize(item_code, min_items, discount_to_apply)
    @item_code = item_code
    @min_items = min_items
    @discount_to_apply = discount_to_apply
  end

  def apply(current_total, order)
    should_discount_be_applied?(order) ? apply_discount(order) : 0
  end

  private

  attr_reader :item_code, :min_items, :discount_to_apply

  def should_discount_be_applied?(order)
    order[item_code] >= min_items
  end

  def apply_discount(order)
    order[item_code] * discount_to_apply
  end
end
