class Product < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 2}
  validates :description, :price, :stock, presence: true
end
