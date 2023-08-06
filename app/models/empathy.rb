class Empathy < ApplicationRecord

  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }

  enum empathy: { happy: 1, sad: 2, love: 3, anger: 4 }

end
