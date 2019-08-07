class SpaceSerializer < ActiveModel::Serializer
  attributes :id, :longitude, :latitude, :users
end
