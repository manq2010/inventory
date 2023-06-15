# app/controllers/members_controller.rb
class MembersController < ApplicationController
  before_action :authenticate_user!

  #  user from token function
  def show
    user = get_user_from_token
    render json: {
      message: "If you see this, you're in!",
      user: user
    }
  end

  private

  def get_user_from_token
    # jwt_payload = JWT.decode(request.headers['Authorization'].split[1],
    #                          Rails.application.credentials.devise[:jwt_secret_key]).first
    # user_id = jwt_payload['sub']
    # User.find(user_id.to_s)

    jwt_payload = JWT.decode(request.headers['Authorization'].split[1],
                             Rails.application.credentials.fetch(:secret_key_base)).first
    User.find(jwt_payload['sub'])

    # jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
    # Rails.application.credentials.fetch(:secret_key_base)).first
    # user_id = jwt_payload['sub']
    # User.find(user_id.to_s)
  end
end
