class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _options = {})
    log_in_success && return if resource.persisted?

    log_in_failure
  end

  def respond_to_on_destroy
    # jwt_payload = JWT.decode(request.headers['Authorization'].split[1],
    # Rails.application.credentials.fetch(:secret_key_base)).first
    # current_user = User.find(jwt_payload['sub'])

    log_out_success && return if current_user

    log_out_failure
  end

  def log_in_success
    render json: {
      status: { code: 200, message: 'Logged in sucessfully' },
      # data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      user: resource
    }, status: :ok
  end

  def log_in_failure
    render json: {
      code: 401,
      message: 'Invalid email or password',
      error: 'Invalid email or password'
    }, status: :unauthorized
  end

  def log_out_success
    render json: {
      code: 200,
      message: 'logout successfully'
    }, status: :ok
  end

  def log_out_failure
    render json: {
      code: 401,
      message: 'Could not find an active session'
    }, status: :unauthorized
  end
end
