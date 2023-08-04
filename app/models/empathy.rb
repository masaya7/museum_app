class Empathy < ApplicationRecord

  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }

  enum empathy: {default: 0, 😀: 1, 😢: 2, 😍: 3, 😤: 4 }

end
