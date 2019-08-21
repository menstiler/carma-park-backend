class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :spaces
  has_many :notifications
  has_many :favorites
end
