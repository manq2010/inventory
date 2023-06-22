class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  before_create :confirm_participant
  after_create_commit { broadcast_message }

  def confirm_participant
    return unless room.is_private

    is_participant = Participant.where(user_id: user.id, room_id: room.id).first
    throw :abort unless is_participant
  end

  private

  def broadcast_message
    # ActionCable.server.broadcast('MessagesChannel', {
    #                                id:,
    #                                body:
    #                              })
    ActionCable.server.broadcast('room_channel', 'message')
  end
end
