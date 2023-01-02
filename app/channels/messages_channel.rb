class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    chatroom = Chatroom.find(params[:chatroom])
    stream_for chatroom
  end

  def unsubscribed
    stop_all_streams
  end
end
