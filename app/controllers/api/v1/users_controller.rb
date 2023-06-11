class Api::V1::UsersController < ApplicationController
  # before_action :set_user, only: %i[show update destroy]
  skip_before_action :authenticate, only: [:create]
  # skip_before_action :authenticate

  def index
    @users = User.all
    render json: @users
  end

  def show
    user = User.friendly.find(params[:id])
    if user
      render json: {
        data: {
          users: user
        }
      }, status: :ok
    else
      render json: {
        data: {
          users: user,
          errors: "Couldn't find a user with id: #{params[:id]}"
        }
      }, status: :bad_request
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { message: 'User created successfully' }, status: :created
    else
      render json: { error: "username #{user.errors[:name].first}" }, status: :bad_request
    end
  end

  def update
    user = User.friendly.find(params[:id])

    if user.update(user_params)
      render json: {
        data: {
          users: user
        }
      }, status: :ok
    else
      render json: {
        data: {
          users: user,
          errors: "Couldn't update user with id: #{params[:id]}"
        }
      }, status: :bad_request
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
        data: {
          errors: "Couldn't delete user with id: #{params[:id]}"
        }
      }, status: :not_found
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :role)
  end
end
