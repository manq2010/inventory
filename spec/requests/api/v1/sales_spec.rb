require 'swagger_helper'

RSpec.describe 'api/v1/sales', type: :request do
  sale_properties = {
    name: { type: :string, default: 'toilets to company x' },
    total_price: { type: :decimal, default: 0 },
    user_id: { type: :number, default: '1' }
    # items: { type: :array, default: [
    #   {
    #     name: 'Item 1',
    #     selling_price: 50,
    #     quantity: 2,
    #     category: 'Category 1'
    #   }
    # ] }
  }

  # item_properties = {
  #   name: { type: :string, default: '4-in-1 toilet' },
  #   selling_price: { type: :decimal, default: 170.21 }
  # }

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
      response(201, 'Created Sale successfully') do
        consumes 'application/json'
        produces 'application/json'
        parameter name: :sale, in: :body, schema: {
          type: :object,
          properties: sale_properties,
          required: %w[name total_price user_id items]
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
        run_test!
      end

      response(400, 'Car not found') do
        run_test!
      end
    end

    put('Update a sale') do
      tags 'Sales'
      response(200, 'successful') do
        let(:id) { '123' }
        response(200, 'User updated successfully') do
          consumes 'application/json'
          produces 'application/json'
          parameter name: :sale, in: :body, schema: {
            type: :object,
            properties: sale_properties,
            required: %w[name total_price]
          }
          run_test!
        end

        response(404, 'Sale not found') do
          run_test!
        end
      end
    end

    delete('delete sale') do
      tags 'Sales'
      response(200, 'successful') do
        let(:id) { '123' }
        run_test!
      end

      response(404, 'Sale not found') do
        run_test!
      end
    end
  end

  path '/api/v1/sales/{id}/items' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    post('Add item to sale') do
      tags 'Sales-Items'
      description 'Add item to sale'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: {
          item_id: { type: :number, default: '1' }
        },
        required: %w[name selling_price quantity]
      }
      response(200, 'Created item and added to sale successfully') do
        run_test!
      end
      response(400, 'Operation not successful because of missing arguments or broken data') do
        run_test!
      end
      response(404, 'Sale not found') do
        run_test!
      end
    end

    get('Show Sale items data') do
      tags 'Sales-Items'
      description 'Get sale items data'
      produces 'application/json'
      response(200, 'Returns the sale items data') do
        run_test!
      end
      response(404, 'Sale not found') do
        run_test!
      end
    end
  end

  path '/api/v1/sales/{id}/items/{item_id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    parameter name: 'item_id', in: :path, type: :string, description: 'item_id'

    put('Update item in sale') do
      tags 'Sales-Items'
      description 'Update item in sale'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, default: '3-in-1 toilet luxury' },
          selling_price: { type: :number, format: :decimal, default: 150.21 },
          quantity: { type: :integer, default: 1 },
          category: { type: :string, default: 'Category 2' }
        },
        required: %w[selling_price item_id]
      }
      response(200, 'Item in sale updated successfully') do
        run_test!
      end
      response(400, 'Operation not successful because of missing arguments or broken data') do
        run_test!
      end
      response(404, 'Sale or item not found') do
        run_test!
      end
    end

    delete('Delete item from sale') do
      tags 'Sales-Items'
      description 'Delete item from sale'
      produces 'application/json'
      response(200, 'Item deleted successfully') do
        run_test!
      end
      response(404, 'Sale or item not found') do
        run_test!
      end
    end
  end

  # path '/api/v1/sales/{id}/update_item/{item_id}' do
  #   parameter name: 'id', in: :path, type: :string, description: 'Sale ID'
  #   parameter name: 'item_id', in: :path, type: :string, description: 'Item ID'

  #   put('Update item in sale') do
  #     tags 'Sales-Items'
  #     description 'Update item in sale'
  #     consumes 'application/json'
  #     produces 'application/json'

  #     parameter name: :item, in: :body, schema: {
  #       type: :object,
  #       properties: {
  #         name: { type: :string, default: '3-in-1 toilet luxury' },
  #         selling_price: { type: :number, format: :decimal, default: 150.21 },
  #         quantity: { type: :integer, default: 1 },
  #         category: { type: :string, default: 'Category 2' }
  #       },
  #       required: %w[selling_price item_id]
  #     }

  #     response '200', 'Item in sale updated successfully' do
  #       schema type: :object,
  #              properties: {
  #                id: { type: :integer },
  #                name: { type: :string },
  #                total_cost: { type: :number, format: :decimal },
  #                created_at: { type: :string, format: 'date-time' },
  #                updated_at: { type: :string, format: 'date-time' }
  #              },
  #              required: %w[id name total_cost created_at updated_at]

  #       let(:id) { Sale.create(name: 'Test Sale').id }
  #       let(:item) do
  #         Item.create(name: 'Test Item',
  #                     selling_price: 100,
  #                     quantity: 1,
  #                     category: 'Test Category')
  #       end
  #       let(:item_id) { item.id }

  #       before do
  #         Sale.find(id).items << item
  #         Sale.find(id).save
  #       end

  #       run_test!
  #     end

  #     response '400', 'Operation not successful because of missing arguments or broken data' do
  #       schema type: :object,
  #              properties: {
  #                message: { type: :string }
  #              },
  #              required: ['message']

  #       let(:id) { Sale.create(name: 'Test Sale').id }
  #       let(:item_id) { 'invalid_id' }
  #       let(:item) do
  #         {
  #           name: 'Test Item',
  #           selling_price: 100,
  #           quantity: 1,
  #           category: 'Test Category'
  #         }
  #       end

  #       run_test!
  #     end

  #     response '404', 'Sale or item not found' do
  #       schema type: :object,
  #              properties: {
  #                message: { type: :string }
  #              },
  #              required: ['message']

  #       let(:id) { 'invalid_id' }
  #       let(:item_id) { 'invalid_id' }
  #       let(:item) do
  #         {
  #           name: 'Test Item',
  #           selling_price: 100,
  #           quantity: 1,
  #           category: 'Test Category'
  #         }
  #       end

  #       run_test!
  #     end
  #   end
  # end
end
