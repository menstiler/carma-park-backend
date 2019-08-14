class UserSpaceSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :space_id, :space
end
