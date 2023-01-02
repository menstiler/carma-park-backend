class Api::ChatroomsController < ApplicationController

  def index
    chatrooms = Chatroom.all
    render json: chatrooms
  end

  def create
    chatroom = Chatroom.create(chatroom_params)
    creator = User.find(chatroom.creator)
    space = Space.find(chatroom.space)
    send_to = nil
    if creator.id == space.owner
      send_to = space.claimer
    else
      send_to = space.owner
    end
    serialized_data = ActiveModelSerializers::Adapter::Json.new(
      ChatroomSerializer.new(chatroom)
    ).serializable_hash
    note = Notification.create(user_id: send_to, message: "#{creator.name} started a chat with you")
    ActionCable.server.broadcast 'notifications_channel', note
    ActionCable.server.broadcast 'chatrooms_channel', {action: 'create', chatroom: serialized_data}
    head :ok
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:space, :creator)
  end

end
