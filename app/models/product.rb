class Product < ActiveRecord::Base

  has_and_belongs_to_many :stores
  mount_uploader :image, ImageUploader

end
