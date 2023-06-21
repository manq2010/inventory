class Api::V1::UsersController < ApplicationController
  # rescue_from ActiveRecord::RecordNotFound, with: :not_found
  # before_action :set_user, only: %i[show update destroy]
  # skip_before_action :authenticate
  # skip_before_action :authenticate_user
  before_action :authenticate_user!, only: %i[me show update]
  before_action :set_user, only: %i[update destroy]
  before_action :set_user_by_username, only: [:show_by_username]

  def index
    users = User.all
    # render json: @users
    render json: users
  end

  def me
    render json: current_user, status: :ok
  end

  def show
    user = User.friendly.find(params[:id])
    # user = User.find(params[:id])
    users = User.all_except(current_user)

    rooms = Room.public_rooms
    room_name = get_name(user, current_user)

    single_room = Room.where(name: room_name).first || Room.create_private_room([user, current_user], room_name)

    messages = single_room.messages.order(created_at: :asc)

    if user
      render json: {
        user: user,
        users: users,
        rooms: rooms,
        room_name: room_name,
        single_room: single_room,
        messages: messages
      }, status: :ok
    else
      render json: {
        user: user,
        errors: "Couldn't find a user with id: #{params[:id]}"
      }, status: :bad_request
    end
  end

  def show_by_username
    if @user
      render json: @user, status: :ok
    else
      render json: {
        message: 'User not found'
      }, status: :not_found
    end
  end

  def search
    user = User.search(params[:username])
    render json: user, status: :ok
  end

  # def create
  #   user = User.new(user_params)
  ##   ActionCable.server.broadcast('user_channel', user) if user.save
  #   if user.save
  #     ActionCable.server.broadcast('user_channel', user)
  #     render json: { message: 'User created successfully' }, status: :created
  #   else
  #     render json: { error: "username #{user.errors[:name].first}" }, status: :bad_request
  #   end
  # end

  def update
    user = User.friendly.find(params[:id])

    if user.update(user_params)
      render json: {
        users: user
      }, status: :ok
    else
      # render json: {
      #     user: (user),
      #     errors: "Couldn't update user with id: #{params[:id]}"
      # }, status: :bad_request
      render_error(user, :unprocessable_entity)
    end
  end

  def destroy
    user = User.friendly.find(params[:id])

    if user&.destroy
      render json: {
        message: "User with id: #{params[:id]} deleted successfully"
      }, status: :accepted
    else
      render json: {
        errors: "Couldn't delete user with id: #{params[:id]}"
      }, status: :not_found
    end
  end

  private

  def user_params
    params.require(:user)
      .permit(
        :first_name,
        :last_name,
        :email,
        :phone,
        :role,
        :id,
        :avatar,
        :username
      )
  end

  # def not_found
  #   render json: { error: 'Not Found' }, status: :not_found
  # end

  def set_user_by_username
    @user = User.find_by(username: params[:username])
  end

  # Render error message
  def render_error(object, status)
    render json: {
      errors: object.errors.full_messages
    }, status: status
  end

  def get_name(user1, user2)
    user = [user1, user2].sort
    # "private_#{user[0].id}_#{user[1].id}"
    "private_#{user[0].slug}_#{user[1].slug}"
  end
end
