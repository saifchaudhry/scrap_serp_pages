class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :customer_review
      t.integer :customer_review_count
      t.string :shipping_message
      t.string :asin
      t.string :image
      t.text :url
      t.boolean :is_prime
      t.boolean :sponsored_ad
      t.string :coupon_info
      t.text :badges_info
      t.timestamps
    end
  end
end
