class User < ApplicationRecord
  serialize :car_image
  serialize :user_image
  has_many :owned_spaces, class_name: "Space", foreign_key: "owner_id"
  has_many :claimed_spaces, class_name: "Space", foreign_key: "claimer_id"
  has_many :messages, dependent: :destroy
  has_many :chatrooms, through: :messages
  has_many :notifications, dependent: :destroy
  has_many :space_logs, dependent: :destroy

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :name, presence: true
  has_secure_password

  def spaces
    Space.where("owner_id = :person_id OR claimer_id = :person_id", person_id: self.id)
  end 

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
