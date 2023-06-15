class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _options = {})
    # if resource.persisted?
    #   render json: {
    #     status: {
    #         code: 200,
    #         message: 'Signed up successfully',
    #         data: resource }
    #   }, status: :ok
    # else
    #   render json: {
    #     status: {
    #         message: 'User could not be created successfully',
    #         errors: resource.errors.full_message }, status: :unprocessable_entity
    #   }
    # end

    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    render json: {
      message: 'Signed up sucessfully.',
      data: resource,
      user: current_user
    }, status: :ok
  end

  def register_failed
    render json: {
      message: 'Something went wrong.'
    }, status: :unprocessable_entity
  end
end
