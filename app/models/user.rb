class User < ApplicationRecord
  serialize :car_image
  serialize :user_image
  has_many :user_spaces, dependent: :destroy
  has_many :spaces, through: :user_spaces
  has_many :messages, dependent: :destroy
  has_many :chatrooms, through: :messages
  has_many :notifications, dependent: :destroy
  has_many :space_logs, dependent: :destroy

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :name, presence: true
  has_secure_password

  def self.create_from_omniauth(profile)
    User.find_or_create_by(uid: profile['googleId']) do |u|
      u.username = profile['name']
      u.name = profile['name']
      u.password = SecureRandom.hex(16)
    end
  end

  def user_serialized
    UserSerializer.new(self)
  end
end
