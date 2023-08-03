class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :empathies, dependent: :destroy
end
