class ChatroomSerializer < ActiveModel::Serializer
  attributes :id, :space
  has_many :messages
end
