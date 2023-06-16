# app/controllers/members_controller.rb
class MembersController < ApplicationController
  before_action :authenticate_user!

  #  user from token function
  def show
    user = get_user_from_token
    render json: {
      message: "If you see this, you're signed in!",
      user: user
    }
  end

  private

  def get_user_from_token
    jwt_payload = JWT.decode(request.headers['Authorization'].split[1],
                             Rails.application.credentials.fetch(:secret_key_base)).first
    User.find(jwt_payload['sub'])
  end
end
