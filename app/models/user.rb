class User < ApplicationRecord
  has_many :user_spaces
  has_many :spaces, through: :user_spaces
  has_many :messages
  has_many :chatrooms, through: :messages
  has_many :notifications
  has_many :favorites

  validates :username, uniqueness: true
  has_secure_password
end
