class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :car_image, :license_plate, :user_image, :car_make, :car_model
  has_many :notifications
  has_many :owned_spaces
  has_many :claimed_spaces
  has_many :space_logs
  has_many :spaces
end
