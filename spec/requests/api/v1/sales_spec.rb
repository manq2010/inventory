require 'swagger_helper'

RSpec.describe 'api/v1/sales', type: :request do
  sale_properties = {
    name: { type: :string, default: 'toilets to company x' },
    total_price: { type: :decimal, default: 0 },
    user_id: { type: :number, default: '1' }
  }

  path '/api/v1/sales' do
    get('List of sales') do
      tags 'Sales'
      parameter name: :sales,
                in: :body
      response(200, 'successful') do
        run_test!
      end
    end

    post('Create a sale') do
      tags 'Sales'
      response(201, 'Created Item successfully') do
        consumes 'application/json'
        produces 'application/json'
        parameter name: :sale, in: :body, schema: {
          type: :object,
          properties: sale_properties,
          required: %w[name total_price user_id]
        }
        run_test!
      end

      response(400, 'Operation not successful because of missing arguments or broken data') do
        run_test!
      end
    end
  end

  path '/api/v1/sales/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('Show a sale') do
      tags 'Sales'
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
    end

    put('update sale') do
      tags 'Sales'
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
    end

    delete('delete sale') do
      tags 'Sales'
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
    end
  end
end
