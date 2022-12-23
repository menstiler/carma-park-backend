class SpaceSerializer < ActiveModel::Serializer
  attributes :id, :longitude, :latitude, :claimed, :owner, :address, :claimer, :deadline, :image, :updated_at, :created_at
  has_many :user_spaces
  has_many :users, through: :user_spaces
end
