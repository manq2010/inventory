class Api::V1::Auth::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  # def respond_with(resource, _opts = {})
  #   if resource.persisted?

  #     render json: resource, status: :ok
  #   else
  #     render json: {
  #       error: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}"
  #     }, status: :unprocessable_entity
  #   end
  # end

  def respond_with(resource, _options = {})
    if request.method === 'POST' && resource.persisted?
      # ActionCable.server.broadcast('user_channel', user) if user.save
      render json: {
        status: { code: 200, message: 'Signed up successfully' },
        # data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
        data: resource
      }, status: :ok
    elsif request.method === 'DELETE'
      render json: {
        status: { code: 200, message: 'Account deleted successfully' }
      }, status: :ok
    else
      render json: {
        status: { code: 422, message: "User could not be created successfully. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end
end
