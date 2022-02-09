require 'net/http'
require 'nokogiri'
require 'open-uri'

class Scraper
  SINGLE_PRODUCT_LINK = 'https://www.amazon.ae/Deniklo-Solid-Regular-Shirt-DK101-M_Red/dp/B07TFRQHY1?ref_=Oct_d_orecs_d_21901924031&pd_rd_w=GT1eV&pf_rd_p=35f5b41d-f9d6-41e4-831d-5edae96f7b42&pf_rd_r=598DG6CQNJPCXS176GAC&pd_rd_r=bf18d723-f298-4c6c-bc64-28daf56b02f2&pd_rd_wg=dee8q&pd_rd_i=B08DXX2D6Q&th=1'
  PRODUCT_INDEX_LINK = 'https://www.amazon.ae/Deniklo-Solid-Regular-Shirt-DK101-M_Red/dp/B08DXX2D6Q?ref_=Oct_d_orecs_d_21901924031&pd_rd_w=GT1eV&pf_rd_p=35f5b41d-f9d6-41e4-831d-5edae96f7b42&pf_rd_r=598DG6CQNJPCXS176GAC&pd_rd_r=bf18d723-f298-4c6c-bc64-28daf56b02f2&pd_rd_wg=dee8q&pd_rd_i=B08DXX2D6Q'
  def self.scrape_product_index
    idaho_url = 'https://www.amazon.ae/b?node=21901924031&pf_rd_r=4VR3HY5S1N1JJCYK8V3Q&pf_rd_p=d51de48f-7d82-4b68-bec5-33cdf24384d9&pd_rd_r=4cd736c6-6b57-4b38-b692-546cfcf3e906&pd_rd_w=8Y25x&pd_rd_wg=HIpvm&ref_=pd_gw_unk'
    html = open(idaho_url)
    doc = Nokogiri::HTML(html)
    doc.css('.a-row').each do |maindiv|
      maindiv.css('ul').css('li').each do |lidiv|
        title = lidiv.css('.octopus-pc-asin-title').css('span').text.strip
        price = lidiv.css('.octopus-pc-asin-price').css('.a-price').text.strip.gsub('priceAED', '')
        customer_review_count = lidiv.css('.octopus-pc-asin-review-star').css('span').text.strip
        image = lidiv.css('.octopus-pc-item-image-section').css('img').attribute('src')&.value
        customer_review = get_reviews(lidiv.css('.octopus-pc-asin-review-star').css('i').attribute('class')&.value)
    create_update_product(title, price, customer_review_count, image, reviews, asin)

      end
    end
  end

  def self.scrap_product(url)
    res = open(url)
    title = doc.css('#productTitle').text.strip
    price = doc.css('#corePrice_desktop').css('span')[0].text.strip.gsub('AED', '')
    customer_review_count = doc.css('#acrCustomerReviewLink').css('#acrCustomerReviewText')[0].text.strip
    image = doc.css('#imgTagWrapperId').css('img').attribute('src')&.value
    customer_review = get_reviews(doc.css('#averageCustomerReviews').css('i').attribute('class')&.value)
    asin = ""
    doc.css('#detailBullets_feature_div').css('li').each do |lidiv|
      if lidiv.css('.a-list-item').css('.a-text-bold').text.strip.split("\n")[0] == "ASIN"
        asin = lidiv.css('.a-list-item').css('span')[2]&.text
      end
    end
    create_update_product(title, price, customer_review_count, image, reviews, asin)
  end

  def self.create_update_product(title, price, customer_review_count, image, reviews, asin)
    product = Product.find_or_initialize_by(asin: asin)
    product.price = price
    product.customer_review_count = customer_review_count
    product.image = image
    product.customer_review = reviews
    product.save

  end

  def self.get_reviews(i)
    return if i.nil?
    if i.include?('a-star-mini-5')
      "5 reviews out of 5"
    elsif i.include?('a-star-mini-4-5')
      "4.5 reviews out of 5"
    elsif i.include?('a-star-mini-4')
      "4 reviews out of 5"
    elsif i.include?('a-star-mini-3-5')
      "3.5 reviews out of 5"
    elsif i.include?('a-star-mini-3')
      "3 reviews out of 5"
    elsif i.include?('a-star-mini-2-5')
      "2.5 reviews out of 5"
    elsif i.include?('a-star-mini-2')
      "2 reviews out of 5"
    elsif i.include?('a-star-mini-1-5')
      "1.5 reviews out of 5"
    elsif i.include?('a-star-mini-1')
      "1 reviews out of 5"
    elsif i.include?('a-star-mini-1')
      "0.5 reviews out of 5"
    elsif i.include?('a-star-mini-1')
      "0 reviews out of 5"
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
















