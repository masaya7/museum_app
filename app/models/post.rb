class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :empathies

  enum status: { published: 0, draft: 1 }
  enum empathy: {default: 0, 😀: 1, 😢: 2, 😍: 3, 😤: 4 }

  def empathize_by?(user)
    empathies.where(user_id: user.id).exists?
  end
end
