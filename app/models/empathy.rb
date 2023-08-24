class Empathy < ApplicationRecord

  belongs_to :user, foreign_key: "user_id", class_name: "User"
  belongs_to :post, foreign_key: "post_id", class_name: "Post"

  validates :user_id, uniqueness: { scope: :post_id }

  enum empathy: { happy: 1, sad: 2, love: 3, anger: 4 }

end
