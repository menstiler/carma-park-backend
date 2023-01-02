class UsersChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_from "users_channel"
  end

  def unsubscribed
    stop_all_streams
  end
end
