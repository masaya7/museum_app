class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user

  enum status: { published: 0, draft: 1 }
end
