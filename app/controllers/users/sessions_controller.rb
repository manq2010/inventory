class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _options = {})
    render json: {
      status: { code: 200, message: 'Logged in successfully' },
      # data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      data: resource
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        code: 200,
        message: 'logout successfully'
      }, status: :ok
    else
      render json: {
        code: 401,
        message: 'Could not find an active session'
      }, status: :unauthorized
    end
  end
end
