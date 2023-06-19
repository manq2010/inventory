# require 'swagger_helper'

# RSpec.describe 'sessions', type: :request do
#   path '/login' do
#     post('Create a session') do
#       tags 'Users-2'
#       response(200, 'Successfully logged in') do
#         consumes 'application/json'
#         produces 'application/json'
#         parameter name: :session, in: :body, schema: {
#           type: :object,
#           properties: {
#             email: { type: :string, default: 'developer@inventory.com' }
#             # password: { type: :string, default: 'test@123' }
#           },
#           required: %w[email]
#         }
#         run_test!
#       end

#       response(401, 'Invalid email or password') do
#         run_test!
#       end
#     end
#   end
# end
