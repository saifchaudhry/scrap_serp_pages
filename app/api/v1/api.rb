module V1
  module ErrorFormatter
    def self.call(message, backtrace, options, env, er)
        { :status => 'failure', :reason => message }.to_json
    end
  end
  class API < Grape::API
    version 'v1', using: :header, vendor: 'product'
    format :json
    prefix :"api/v1"
    error_formatter :json, ErrorFormatter

    resource :product do

      desc 'Get all products'
      get '/' do
        ::Product.all
      end

      desc 'Get specific product by asin'
      get '/:asin' do
        @product = ::Product.find_by(params)
        if @product
          @product
        else
          status 404
          { message: "No product is found by this name" }
        end
      end

      desc 'Create Product'
      params do
        requires :name, type: String
        requires :asin, type: String
        optional :price, type: Integer
        optional :customer_review, type: String
        optional :customer_review_count, type: Integer
        optional :shipping_message, type: String
        optional :image, type: String
        optional :url, type: String
        optional :is_prime, type: Boolean
        optional :sponsored_ad, type: Boolean
        optional :coupon_info, type: String
        optional :badges_info, type: String

      end
      post do
        product = ::Product.find_or_initialize_by(name: params[:name])
        product.assign_attributes(params)
        if product.save
          product
        else
          error!({ status: 'failure', reason: product.errors.full_messages } , 400)
        end
      end

      desc 'Delete specific product by asin'
      delete '/:asin' do
        @product = ::Product.find_by(params)
        if @product
          @product.destroy
          { message: "Product Deleted" }
        else
          status 404
          { message: "Product not found" }
        end
      end

      desc 'Update Product'
      params do
        requires :name, type: String
        requires :asin, type: String
        optional :price, type: Integer
        optional :customer_review, type: String
        optional :customer_review_count, type: Integer
        optional :shipping_message, type: String
        optional :image, type: String
        optional :url, type: String
        optional :is_prime, type: Boolean
        optional :sponsored_ad, type: Boolean
        optional :coupon_info, type: String
        optional :badges_info, type: String
      end
      route_param :id do
        patch do
          @product = ::Product.find_by_id(params[:id])
          if @product
            @product.update(params)
            @product.reload
          else
            status 404
            { message: "Product not found" }
          end
        end
      end

    end
  end
end