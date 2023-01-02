class ChatroomsChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_from "chatrooms_channel"
  end

  def unsubscribed
    stop_all_streams
  end
end
