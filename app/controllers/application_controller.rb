class ApplicationController < ActionController::API
  # before_action :authenticate
  # attr_reader :current_user_id

  # private

  # def authenticate
  #   secret = ENV.fetch('JWT_SECRET_KEY', nil)
  #   token = request.headers['Authorization']&.split&.last
  #   begin
  #     payload = JWT.decode(token, secret, true, algorithm: 'HS256').first
  #     @current_user_id = payload['user_id']
  #   rescue JWT::DecodeError
  #     render json: { error: 'You are not allowed to access this api, please login' }, status: :unauthorized
  #   end
  # end

  # protect_from_forgery with: :exception

  # before_action :update_allowed_parameters, if: :devise_controller?

  # protected

  # def update_allowed_parameters
  #   devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :password, :phone, :email, :password_confirmation) }
  #   devise_parameter_sanitizer.permit(:account_update) do |u|
  #     u.permit(:first_name, :last_name, :password, :phone, :email, :password_confirmation)
  #   end
  # end
end
