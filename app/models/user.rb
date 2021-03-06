class User < ApplicationRecord
  has_many :user_spaces, dependent: :destroy
  has_many :spaces, through: :user_spaces
  has_many :messages
  has_many :chatrooms, through: :messages
  has_many :notifications, dependent: :destroy
  has_many :favorites

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :name, presence: true
  has_secure_password
end
