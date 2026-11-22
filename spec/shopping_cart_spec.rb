require_relative "../support/shopping_cart"

RSpec.describe ShoppingCart do
  subject(:cart) { described_class.new }

  it("starts empty") { expect(cart.total_cents).to eq(0) }

  it "totals multiple products and quantities in integer cents" do
    cart.add(name: "Pen", price_cents: 125, quantity: 3)
    cart.add(name: "Book", price_cents: 999)
    expect(cart.total_cents).to eq(1374)
  end

  it "accumulates repeated items" do
    2.times { cart.add(name: "Pen", price_cents: 125) }
    expect(cart.total_cents).to eq(250)
  end

  it "removes an item and reports missing items" do
    cart.add(name: "Pen", price_cents: 125)
    expect(cart.remove("Pen")).to be true
    expect(cart.total_cents).to eq(0)
    expect(cart.remove("Pen")).to be false
  end

  it "rejects invalid inputs" do
    [
      { name: "", price_cents: 100 },
      { name: "Pen", price_cents: -1 },
      { name: "Pen", price_cents: 1.5 },
      { name: "Pen", price_cents: 100, quantity: 0 },
      { name: "Pen", price_cents: 100, quantity: -1 }
    ].each { |args| expect { cart.add(**args) }.to raise_error(ArgumentError) }
    expect(cart.total_cents).to eq(0)
  end

  it "rejects conflicting prices without changing the cart" do
    cart.add(name: "Pen", price_cents: 125)
    expect { cart.add(name: "Pen", price_cents: 200) }.to raise_error(ArgumentError)
    expect(cart.total_cents).to eq(125)
  end
end
