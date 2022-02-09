# README
## API Details Below

# Get all products
	{BASE_URL}/api/v1/product/
-----------------------

# Get specific product detail by asin
	{BASE_URL}/api/v1/product/:asin
-----------------------

# Update specific product detail by asin
	{BASE_URL}/api/v1/product/:id

	Required Params:
	requires :name
	requires :asin
	optional :price
	optional :customer_review
	optional :customer_review_count
	optional :shipping_message
	optional :image
	optional :url
	optional :is_prime
	optional :sponsored_ad
	optional :coupon_info
	optional :badges_info
-----------------------

# Create a product 
	{BASE_URL}/api/v1/product/

	Required Params:
	requires :name
	requires :asin
	optional :price
	optional :customer_review
	optional :customer_review_count
	optional :shipping_message
	optional :image
	optional :url
	optional :is_prime
	optional :sponsored_ad
	optional :coupon_info
	optional :badges_info
-----------------------

# Delete specific product detail by asin
	{BASE_URL}/api/v1/product/:asin


	--------------------------------------------------------------------------------------------------------------------------------      


## Paths

# You can find api here :
	/app/api/v1/api.rb
-----------------------

# Scrapping has been done in following service :
	/app/services/scraper.rb
-----------------------

# ProxyCrawl can be find in service :
	/app/services/proxy_crawl.rb
-----------------------

# ProxyCrawl Job Worker can be find in :
	/app/workers/proxy_crawl_worker.rb
-----------------------

# Job Schaduling configuration :
	/config/schedule.rb
-----------------------

# Validations has been done in following model :
	/app/models/product.rb
-----------------------

# Rspecs are written in following folders :
	/spec/models
	/spec/requests
-----------------------

# Credentials are written in :
	/config/credentials.yml.enc
-----------------------

