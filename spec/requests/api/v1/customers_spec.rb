# require 'swagger_helper'

# RSpec.describe 'api/v1/customers', type: :request do
#   customer_properties = {
#     name: { type: :string, default: 'Chillers Wheels' },
#     email: { type: :string, default: 'chillers@wheels.com' },
#     country_code: { type: :string, default: 'South Africa' },
#     address: { type: :string, default: '123 Main St, Limpopo' }
#   }

#   path '/api/v1/customers' do
#     get('Retrieves a list of customers') do
#       tags 'Customers'
#       response(200, 'Successful') do
#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end
#         run_test!
#       end
#     end

#     post('Creates a customer') do
#       tags 'Customers'
#       response(201, 'Created customer successfully') do
#         consumes 'application/json'
#         produces 'application/json'
#         parameter name: :customer, in: :body, schema: {
#           type: :object,
#           properties: customer_properties,
#           required: %w[name email country_code address]
#         }

#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end
#         run_test!
#       end

#       response(400, 'Operation not successful due to missing arguments or invalid data') do
#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end
#         run_test!
#       end
#     end
#   end

#   path '/api/v1/customers/{id}' do
#     parameter name: 'id', in: :path, type: :string, description: 'Customer ID'

#     get('Retrieves a single customer') do
#       tags 'Customers'
#       response(200, 'Successful') do
#         let(:id) { '123' }
#         run_test!
#       end

#       response(400, 'Customer not found') do
#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end
#         run_test!
#       end
#     end

#     put('Updates a customer') do
#       tags 'Customers'
#       response(200, 'Successful') do
#         let(:id) { '123' }
#         consumes 'application/json'
#         produces 'application/json'
#         parameter name: :customer, in: :body, schema: {
#           type: :object,
#           properties: customer_properties,
#           required: %w[name email country_code address]
#         }

#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end
#         run_test!
#       end

#       response(404, 'Customer not found') do
#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end
#         run_test!
#       end
#     end

#     delete('Deletes a customer') do
#       tags 'Customers'
#       response(200, 'Successful') do
#         let(:id) { '123' }

#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end
#         run_test!
#       end

#       response(404, 'Customer not found') do
#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end
#         run_test!
#       end
#     end
#   end
# end
