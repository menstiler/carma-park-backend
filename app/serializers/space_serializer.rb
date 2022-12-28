class SpaceSerializer < ActiveModel::Serializer
  attributes :id, :longitude, :latitude, :claimed, :owner_id, :address, :claimer_id, :deadline, :image, :updated_at, :created_at, :owner, :claimer
end

