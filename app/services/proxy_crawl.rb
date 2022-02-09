class ProxyCrawl
  require 'net/http'

  def self.run
    uri = URI('https://api.proxycrawl.com')
    uri.query = URI.encode_www_form({ token: Rails.application.credentials.config[:proxy_crawl_token], url: 'https://www.amazon.com/s?k=games' })
    res = Net::HTTP.post_form(uri, 'scraper' => 'amazon-serp')

    res_body = JSON.parse(res.body)['body']['products']
    res_body.each do |p|
      product = Product.find_or_initialize_by(name: p['name'])
      product.assign_attributes(parse_params(p))
      product.save
    end
  end

  def self.parse_params(p)
    { 
      price: p["price"],
      customer_review: p["customerReview"],
      customer_review_count: p["customerReviewCount"],
      shipping_message: p["shippingMessage"],
      asin: p["asin"],
      image: p["image"],
      url: p["url"],
      is_prime: p["isPrime"],
      sponsored_ad: p["sponsoredAd"],
      coupon_info: p["couponInfo"],
      badges_info: p["badgesInfo"]
    }
  end
end
