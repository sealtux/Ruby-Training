module CartValidation
  private

  def validate_item!(name, price_cents, quantity)
    raise ArgumentError, "Name is required" if name.to_s.strip.empty?
    raise ArgumentError, "Price must be nonnegative integer cents" unless price_cents.is_a?(Integer) && price_cents >= 0
    raise ArgumentError, "Quantity must be a positive integer" unless quantity.is_a?(Integer) && quantity > 0
  end
end

class ShoppingCart
  include CartValidation

  def initialize
    @items = {}
  end

  def add(name:, price_cents:, quantity: 1)
    validate_item!(name, price_cents, quantity)
    existing = @items[name]
    if existing && existing[:price_cents] != price_cents
      raise ArgumentError, "An existing item's price cannot change"
    end
    @items[name] = { price_cents: price_cents, quantity: quantity + (existing ? existing[:quantity] : 0) }
    self
  end

  def remove(name)
    !!@items.delete(name)
  end

  def total_cents
    @items.values.sum { |item| item[:price_cents] * item[:quantity] }
  end
end
