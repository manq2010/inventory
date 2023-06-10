# class SessionsController < ApplicationController
#   skip_before_action :authenticate

#   def create
#     user = User.find_by(email: params[:email])

#     if user&.authenticate(params[:password])
#       secret = ENV.fetch('JWT_SECRET_KEY', nil)
#       token = JWT.encode({ user_id: user.id }, secret, 'HS256')
#       render json: { email: user.email, token: token }
#     else
#       render json: { error: 'Invalid email or password' }, status: :unauthorized
#     end
#   end
# end

class SessionsController < ApplicationController
  skip_before_action :authenticate
  def create
    secret = ENV.fetch('JWT_SECRET_KEY', nil)
    user = User.find_by(email: params[:email])
    if user
      token = JWT.encode({ user_id: user.id }, secret, 'HS256')
      # decoded_token = JWT.decode token, secret, true, { :algorithm => 'HS256' }
      render json: { token: token }
    else
      render json: { error: 'Invalid email' }, status: :unauthorized
    end
  end
end
