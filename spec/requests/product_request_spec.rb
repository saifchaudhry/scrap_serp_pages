require 'rails_helper'

RSpec.describe "Products", type: :request do
	# initialize test data
	let!(:product) {Product.create(name: "testproduct", asin: "B072V34568CD") }
  let!(:product1) { Product.create(name: "Test", price: 0, customer_review: "4.6 out of 5 stars", customer_review_count: 462, shipping_message: "Get it as soon as Fri", asin: "B072V8CD", image: "https://m.media-amazon.com/images/...", url: "https://www.amazon.com/...", is_prime: true, sponsored_ad: false, coupon_info: "", badges_info: [])}

  
  # Test suite for GET /products
  describe 'GET /products' do
    # make HTTP get request before each example
    before { get "/api/v1/product/" }

    it 'returns products' do
      # Note `json` is a custom helper to parse JSON responses
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

  end
# //********************************
  describe 'GET specific product' do
    # make HTTP get request before each example
    before { get "/api/v1/product/B072V34568CD" }

    it 'returns specific product' do
      # Note `json` is a custom helper to parse JSON responses
      expect(JSON.parse(response.body)["name"]).to eq("testproduct")
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
    
  end
# //********************************
  describe 'GET specific product' do
    # make HTTP get request before each example
    before { get URI.escape("/api/v1/product/B072V8CD") }

    it 'returns specific product' do
      # Note `json` is a custom helper to parse JSON responses
      expect(JSON.parse(response.body)["name"]).to eq("Test")
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
    
  end
# //********************************

  describe 'GET specific product by invalid asin' do
    # make HTTP get request before each example
    before { get URI.escape("/api/v1/product/nonexisting") }

    it 'returns error' do
      # Note `json` is a custom helper to parse JSON responses
      expect(JSON.parse(response.body)["message"]).to eq("No product is found by this name")
    end

    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end
    
  end


# //********************************

  describe 'DELETE specific product by asin' do
    # make HTTP get request before each example
    before { delete URI.escape("/api/v1/product/B072V8CD") }

    it 'returns approrpriate message' do
      # Note `json` is a custom helper to parse JSON responses
      expect(JSON.parse(response.body)["message"]).to eq("Product Deleted")
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
    
  end

  # //********************************

  describe 'Update specific product by id' do
    # make HTTP get request before each example
    before { patch URI.escape("/api/v1/product/#{product.id}"), params: { name: "TestUpdate", price: 0, customer_review: "4.6 out of 5 stars", customer_review_count: 462, shipping_message: "Get it as soon as Fri", asin: "B072V3456788CD", image: "https://m.media-amazon.com/images/...", url: "https://www.amazon.com/...", is_prime: true, sponsored_ad: false, coupon_info: ""} }

    it 'returns approrpriate message' do
      # Note `json` is a custom helper to parse JSON responses
      expect(JSON.parse(response.body)["name"]).to eq("TestUpdate")
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
    
  end

# //********************************

  describe 'CREATE specific product' do
    # make HTTP get request before each example
    before { post URI.escape("/api/v1/product"), params: { name: "TestName1", price: 0, customer_review: "4.6 out of 5 stars", customer_review_count: 462, shipping_message: "Get it as soon as Fri", asin: "Z72V34567D", image: "https://m.media-amazon.com/images/...", url: "https://www.amazon.com/...", is_prime: true, sponsored_ad: false, coupon_info: ""} }

    it 'returns approrpriate message' do
      # Note `json` is a custom helper to parse JSON responses
      expect(JSON.parse(response.body)["name"]).to eq("TestName1")
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(201)
    end
    
  end

# //********************************

  describe 'Verify CREATE specific product without required information' do
    # make HTTP get request before each example
    before { post URI.escape("/api/v1/product"), params: { name: "TestName1"} }

    it 'returns approrpriate message' do
      # Note `json` is a custom helper to parse JSON responses
      expect(JSON.parse(response.body)["reason"]).to eq("asin is missing")
    end

    it 'returns status code 400' do
      expect(response).to have_http_status(400)
    end
    
  end

end