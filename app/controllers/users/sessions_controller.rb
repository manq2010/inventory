class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _options = {})
    log_in_success && return if resource.persisted?

    log_in_failure
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split[1],
                             Rails.application.credentials.fetch(:secret_key_base)).first
    current_user = User.find(jwt_payload['sub'])

    log_out_success && return if current_user

    log_out_failure
  end

  def log_in_success
    render json: {
      code: 200,
      message: 'User signed in successfully',
      user: resource
    }, status: :ok
  end

  def log_in_failure
    # puts 'login-failure'
    # render json: {
    #   message: 'Something went wrong.'
    # }, status: :unprocessable_entity
    #     render json: {
    #   status: {
    #     code: 401,
    #     message: 'Invalid email or password'
    #   }
    # }, status: :unauthorized
    
    render json: { error: 'Invalid email' }, status: :unauthorized
  end

  def log_out_success
    render json: {
      status: 200,
      message: 'You are logged out.'
    }, status: :ok
  end

  def log_out_failure
    render json: {
      status: 401,
      message: 'Hmm nothing happened.'
    }, status: :unauthorized
  end
end
