class ChatroomsController < ApplicationController

  def index
    chatrooms = Chatroom.all
    render json: chatrooms
  end

  def create
    chatroom = Chatroom.create(chatroom_params)
    serialized_data = ActiveModelSerializers::Adapter::Json.new(
      ChatroomSerializer.new(chatroom)
    ).serializable_hash
    ActionCable.server.broadcast 'chatrooms_channel', serialized_data
    head :ok
  end

  def destroy
    chatroom = Chatroom.find_by(space: params[:id])
    chatroom.destroy
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:space)
  end

end
