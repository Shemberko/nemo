class Post < ApplicationRecord
  belongs_to :post_category
  validates :title, presence: true, length: {minimum: 1}
  validates :description, presence: true, length: {minimum: 5}
  mount_uploader :photo, PhotoUploader
end
