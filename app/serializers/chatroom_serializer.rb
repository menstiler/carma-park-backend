class ChatroomSerializer < ActiveModel::Serializer
  attributes :id, :space, :creator
  has_many :messages
end
