require 'swagger_helper'

RSpec.describe 'api/v1/customers', type: :request do
  customer_properties = {
    name: { type: :string, default: 'Chillers Wheels' },
    email: { type: :string, default: 'chillers@wheels.com' },
    country_code: { type: :string, default: 'South Africa' },
    address: { type: :string, default: '123 Main St, Limpopo' }
  }

  path '/api/v1/customers' do
    get('List of customers') do
      tags 'Customers'
      response(200, 'Successful') do
        run_test!
      end
    end

    post('Create a customer') do
      tags 'Customers'
      response(201, 'Created customer successfully') do
        consumes 'application/json'
        produces 'application/json'
        parameter name: :customer, in: :body, schema: {
          type: :object,
          properties: customer_properties,
          required: %w[name email country_code address]
        }
        run_test!
      end

      response(400, 'Operation not successful due to missing arguments or invalid data') do
        run_test!
      end
    end
  end

  path '/api/v1/customers/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'Customer ID'

    get('Show a customer') do
      tags 'Customers'
      response(200, 'Successful') do
        let(:id) { '123' }
        run_test!
      end

      response(400, 'Customer not found') do
        run_test!
      end
    end

    put('Update a customer') do
      tags 'Customers'
      response(200, 'Successful') do
        let(:id) { '123' }
        consumes 'application/json'
        produces 'application/json'
        parameter name: :customer, in: :body, schema: {
          type: :object,
          properties: customer_properties,
          required: %w[name email country_code address]
        }
        run_test!
      end

      response(404, 'Customer not found') do
        run_test!
      end
    end

    delete('Delete a customer') do
      tags 'Customers'
      response(200, 'Successful') do
        let(:id) { '123' }
        run_test!
      end

      response(404, 'Customer not found') do
        run_test!
      end
    end
  end
end
