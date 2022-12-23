class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :car_image, :license_plate, :user_image, :car_make, :car_model
  has_many :notifications
  has_many :spaces
  has_many :space_logs
end
