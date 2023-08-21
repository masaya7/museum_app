class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :empathies
  has_one_attached :image

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 4000 }
  validates :image, presence: true

  enum status: { published: 0, draft: 1 }

  def empathize_by?(user)
    empathies.where(user_id: user.id).exists?
  end
end
