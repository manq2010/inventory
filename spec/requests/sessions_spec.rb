require 'swagger_helper'

RSpec.describe 'sessions', type: :request do
  path '/login' do
    post('Create a session') do
      tags 'Users'
      response(200, 'Successfully logged in') do
        consumes 'application/json'
        produces 'application/json'
        parameter name: :session, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string, default: 'test' }
            # password: { type: :string, default: 'test@123' }
          },
          required: %w[email password]
        }
        run_test!
      end

      response(401, 'Invalid email or password') do
        run_test!
      end
    end
  end
end
