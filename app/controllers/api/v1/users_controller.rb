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
    if user
      render json: {
        user: user
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
  #   if user.save
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
end
