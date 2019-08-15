class SpacesChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "spaces_channel"
  end

  def unsubscribed
    raise "huh?"
    # Any cleanup needed when channel is unsubscribed
  end
end
