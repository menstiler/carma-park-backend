class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username
  has_many :notifications
  has_many :favorites
  has_many :spaces
  has_many :user_spaces
end
