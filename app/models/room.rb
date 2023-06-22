class Room < ApplicationRecord
  validates_uniqueness_of :name
  scope :public_rooms, -> { where(is_private: false) }
  #   after_create_commit { broadcast_append_to 'rooms' }
  after_create_commit { broadcast_room }

  has_many :messages
  has_many :participants

  def self.create_private_room(users, room_name)
    single_room = Room.create(name: room_name, is_private: true)
    users.each do |user|
      Participant.create(user_id: user.id, room_id: single_room.id)
    end
    single_room
  end

  private

  def broadcast_room(room)
    # ActionCable.server.broadcast('room_channel', {
    #                                id:,
    #                                body:
    #                              })
    ActionCable.server.broadcast('room_channel', 'room' ) unless is_private
  end
end
