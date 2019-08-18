class User < ApplicationRecord
  has_many :user_spaces
  has_many :spaces, through: :user_spaces
  has_many :messages
  has_many :chatrooms, through: :messages
  has_many :notifications

  validates :username, uniqueness: true
  has_secure_password
end
