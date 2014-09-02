class Product < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 2}
  validates :description, :price, :stock, presence: true

  # Paperclip Image attachment
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/missing.png"
  validates_attachment_content_type :photo, :content_type => ['image']
end
