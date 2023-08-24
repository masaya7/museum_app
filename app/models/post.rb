class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user, foreign_key: "user_id", class_name: "User"
  has_many :empathies
  has_one_attached :image
  attr_accessor :composed_image_path

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 4000 }
  validates :image, presence: true

  enum status: { published: 0, draft: 1 }

  def empathize_by?(user)
    empathies.where(user_id: user.id).exists?
  end
end