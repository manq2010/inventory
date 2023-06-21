class Api::V1::MessagesController < ApplicationController
  before_action :authenticate_user!
  def index
    messages = Message.all
    render json: messages
  end

  def create
    message = current_user.messages.create(body: msg_params[:body], room_id: params[:room_id])

    if message.save
      ActionCable.server.broadcast('room_channel', message)
      render json: { message: message }, status: :ok
    else
      render json: { error: message.errors }, status: :bad_request
    end
  end

  private

  def msg_params
    params.require(:message).permit(:body)
  end
end
