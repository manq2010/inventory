require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
  user_properties = {
    name: { type: :string, default: 'test' }
    # email: { type: :string, default: 'test@test.com' },
    # username: { type: :string, default: 'tester' },
    # password: { type: :string, default: 'test@123' },
    # role: { type: :string, default: 'admin' }
  }

  path '/api/v1/users' do
    get('List of users') do
      tags 'Users'
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/signup' do
    post('Create a new user') do
      tags 'Users'
      response(201, 'User created successfully') do
        consumes 'application/json'
        produces 'application/json'
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: user_properties,
          required: %w[name]
        }
        run_test!
      end

      response(400, 'Username already exists / blank username') do
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    get('show user') do
      tags 'Users'
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, 'User with Id not found') do
        run_test!
      end
    end

    put('update user') do
      tags 'Users'
      response(200, 'successful') do
        let(:id) { '123' }
        response(200, 'User updated successfully') do
          consumes 'application/json'
          produces 'application/json'
          parameter name: :user, in: :body, schema: {
            type: :object,
            properties: user_properties,
            required: %w[name]
          }
          run_test!
        end
      end
    end

    delete('delete user') do
      tags 'Users'
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, 'User with Id not found') do
        run_test!
      end
    end
  end
end
