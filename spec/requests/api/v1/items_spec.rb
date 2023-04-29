require 'swagger_helper'

RSpec.describe 'api/v1/items', type: :request do
  item_properties = {
    name: { type: :string, default: '4-in-1 toilet' },
    buying_price: { type: :decimal, default: 150.51 },
    selling_price: { type: :decimal, default: 170.21 },
    item_quantity: { type: :number, default: 10 },
    category: { type: :string, default: 'Toilets' },
    images: { type: :array, default: [
      'https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/WhatsApp-Image-2021-03-24-at-15.37.25-q1kvizfrdbuc8fb5uqy8g7ctdcji97y4z81i4nl3b0.jpeg',
      'https://chillersonwheels.co.za/wp-content/uploads/elementor/thumbs/CHILLERS-26-1024x728-1-q1kvizfrdbuc8fb5uqy8g7ctdcji97y4z81i4nl3b0.jpeg'
    ] }
  }

  path '/api/v1/items' do
    get('List of items') do
      tags 'Items'
      parameter name: :items,
                in: :body
      response(200, 'successful') do
        run_test!
      end
    end

    post('Create an Item') do
      tags 'Items'
      response(201, 'Created Item successfully') do
        consumes 'application/json'
        produces 'application/json'
        parameter name: :item, in: :body, schema: {
          type: :object,
          properties: item_properties,
          required: %w[name buying_price item_quantity category images]
        }
        run_test!
      end

      response(400, 'Operation not successful because of missing arguments or broken data') do
        run_test!
      end
    end
  end

  path '/api/v1/items/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('Show specific item using {id}') do
      tags 'Items'
      response(200, 'successful') do
        let(:id) { '123' }
        run_test!
      end

      response(400, 'Car not found') do
        run_test!
      end
    end

    put('update item') do
      tags 'Items'
      response(200, 'successful') do
        let(:id) { '123' }
        response(200, 'User updated successfully') do
          consumes 'application/json'
          produces 'application/json'
          parameter name: :item, in: :body, schema: {
            type: :object,
            properties: item_properties,
            required: %w[name buying_price item_quantity category images]
          }
          run_test!
        end
      end
    end

    delete('Delete an Item by {id}') do
      tags 'Items'
      response(202, 'Deleted Item successfully') do
        let(:id) { '123' }
        run_test!
      end

      response(404, 'Item not found') do
        run_test!
      end
    end
  end
end
