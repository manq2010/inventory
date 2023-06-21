class RoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'room_channel'
  end

  def unsubscribed; end
end
