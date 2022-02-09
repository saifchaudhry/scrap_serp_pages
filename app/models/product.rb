class Product < ApplicationRecord

  serialize :badges_info, Array
  
  validates_presence_of :name, :asin
  validates_uniqueness_of :name, :asin, case_sensitive: true

end
