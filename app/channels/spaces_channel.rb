class SpacesChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_from "spaces_channel"
  end

  def unsubscribed
    stop_all_streams
  end
end
