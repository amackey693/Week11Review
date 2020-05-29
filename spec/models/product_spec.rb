require 'rails_helper'

describe Product do
  it { should have_many(:reviews) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :cost }
  it { should validate_presence_of :country_of_origin }
  it { should validate_numericality_of :cost}

  it("titleizes a product before it's SAVED") do
    product = Product.create({name: "this is a test"})
    expect(product.name()).to(eq("This is a Test"))
  end
end
