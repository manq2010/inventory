class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  skip_before_action :authenticate, only: [:create]

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(name: params[:name])
    if @user.save
      render json: { message: 'User created successfully' }, status: :created
    else
      render json: { error: "username #{@user.errors[:name].first}" }, status: :bad_request
    end
  end

  # def create
  #   @user = User.new(user_params)
  #   # @user.password_digest = BCrypt::Password.create(user_params[:password])

  #   if @user.save
  #     render json: { message: 'User created successfully' }, status: :created
  #   else
  #     render json: { error: "username #{@user.errors[:name].first}" }, status: :bad_request
  #   end
  # end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  # def set_user
  #   @user = User.find(params[:id])
  # end

  def user_params
    params.require(:user).permit(:name, :email, :username, :password, :role)
  end
end
