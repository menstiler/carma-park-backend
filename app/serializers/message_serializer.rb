class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :chatroom_id, :created_at, :user
end
