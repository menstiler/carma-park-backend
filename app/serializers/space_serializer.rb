class SpaceSerializer < ActiveModel::Serializer
  attributes :id, :longitude, :latitude, :claimed, :owner, :address, :claimer, :available, :deadline
end
