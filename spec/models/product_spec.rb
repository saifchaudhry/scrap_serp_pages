require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:product) {Product.create(name: "Product One", asin: "B07234568CD") }
  let!(:product1) { Product.create(name: "Product Two", price: 0, customer_review: "4.6 out of 5 stars", customer_review_count: 462, shipping_message: "Get it as soon as Fri", asin: "B0734562V8CD", image: "https://m.media-amazon.com/images/...", url: "https://www.amazon.com/...", is_prime: true, sponsored_ad: false, coupon_info: "", badges_info: [])}

  # Validation tests
  # ensure columns username is present and unique
  it { should validate_presence_of :name }
  it { should validate_presence_of(:asin) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:asin) }
  
end