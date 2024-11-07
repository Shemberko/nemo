class Post < ApplicationRecord
  belongs_to :post_category
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: {minimum: 1}
  validates :description, presence: true, length: {minimum: 5}

  mount_uploader :photo, PhotoUploader

  def is_my?(current_user)
    self.user == current_user
  end
end
