class Api::V1::RoomsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_room, only: %i[create update destroy]

  def index
    # Room.new
    rooms = Room.public_rooms

    users = User.all_except(current_user)
    # render json: @users
    render json: {
      user: current_user,
      rooms: rooms,
      users: users
    }, status: :ok
  end

  def show
    # user = User.friendly.find(params[:id])
    single_room = Room.find(params[:id])

    # Room.new
    rooms = Room.public_rooms

    # Message.new
    messages = single_room.messages.order(created_at: :asc)

    users = User.all_except(current_user)
    if single_room
      render json: {
        rooms: rooms,
        messages: messages,
        users: users,
        single_room: single_room
      }, status: :ok
    else
      render json: {
        errors: single_room.errors
      }, status: :bad_request
    end
  end

  def create
    room = Room.new(room_params)
    if room.save
      # ActionCable.server.broadcast('room_channel', room) unless room.is_private
      render json: { message: 'Room created successfully' }, status: :created
    else
      render json: { error: room.errors }, status: :bad_request
    end
  end

  private

  def room_params
    params.require(:room)
      .permit(
        :name
      )
  end
end
