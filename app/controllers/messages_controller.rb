class MessagesController < ApplicationController

  def create
    message = Message.create(message_params)
    chatroom = Chatroom.find(message_params[:chatroom_id])
    serialized_data = ActiveModelSerializers::Adapter::Json.new(
      MessageSerializer.new(message)
    ).serializable_hash
    MessagesChannel.broadcast_to chatroom, serialized_data
    head :ok
  end

  private

  def message_params
    params.require(:message).permit(:content, :chatroom_id, :user_id)
  end
end
