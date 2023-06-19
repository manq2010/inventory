# require 'swagger_helper'

# RSpec.describe 'api/v1/items', type: :request do
#   item_properties = {
#     title: { type: :string, default: '4-in-1 toilet' },
#     description: { type: :string, default: 'Maximum ventilation (6 vents). Ventilation pipe
#     Roomy interior. Anti-slip floor surface. Occupancy signal latch. Double toilet roll holder.
#     White roof for enhanced natural light. Carry handles. Toilet seat and flap.
#     Free-standing basin with a foot pump. Flushing system' },
#     price: { type: :decimal, default: 880 },
#     quantity: { type: :integer, default: 5 },
#     category: { type: :string, default: 'Toilets' },
#     sku: { type: :string, default: 'TCW001' },
#     tag: { type: :string, default: 'Builders Toilet, Portable Toilet' },
#     color: { type: :string, default: 'Dark Green' },
#     weight: { type: :integer, default: 74 },
#     size: { type: :string, default: '880 × 920 × 1940' },
#     images: { type: :array, default: [
#       'https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/WhatsApp-Image-2021-03-24-at-15.37.25-q1kvizfrdbuc8fb5uqy8g7ctdcji97y4z81i4nl3b0.jpeg',
#       'https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/CHILLERS-26-1024x728-1-q1kvizfrdbuc8fb5uqy8g7ctdcji97y4z81i4nl3b0.jpeg'
#     ] }
#   }

#   path '/api/v1/items' do
#     get('List of items') do
#       tags 'Items'
#       parameter name: :items,
#                 in: :body
#       response(200, 'successful') do
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

#     post('Create an Item') do
#       tags 'Items'
#       response(201, 'Created Item successfully') do
#         consumes 'application/json'
#         produces 'application/json'
#         parameter name: :item, in: :body, schema: {
#           type: :object,
#           properties: item_properties,
#           required: %w[name buying_price item_quantity category images]
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

#       response(400, 'Operation not successful because of missing arguments or broken data') do
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

#   path '/api/v1/items/{id}' do
#     parameter name: 'id', in: :path, type: :string, description: 'id'

#     get('Show specific item using {id}') do
#       tags 'Items'
#       response(200, 'successful') do
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

#       response(400, 'Car not found') do
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

#     put('update item') do
#       tags 'Items'
#       response(200, 'successful') do
#         let(:id) { '123' }
#         response(200, 'User updated successfully') do
#           consumes 'application/json'
#           produces 'application/json'
#           parameter name: :item, in: :body, schema: {
#             type: :object,
#             properties: item_properties,
#             required: %w[name buying_price item_quantity category images]
#           }

#           after do |example|
#             example.metadata[:response][:content] = {
#               'application/json' => {
#                 example: JSON.parse(response.body, symbolize_names: true)
#               }
#             }
#           end
#           run_test!
#         end
#       end
#     end

#     delete('Delete an Item by {id}') do
#       tags 'Items'
#       response(202, 'Deleted Item successfully') do
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

#       response(404, 'Item not found') do
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
