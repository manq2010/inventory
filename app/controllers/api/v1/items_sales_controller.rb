class Api::V1::ItemsSalesController < ApplicationController
  skip_before_action :authenticate
  #   before_action :set_sale, only: %i[add_item update_item delete_item sale_items_data]

  # api/v1/sales/:id/items/
  def add_item
    item = Item.find_by(id: params[:item_id])
    sale = Sale.find_by(id: params[:id])

    if item.nil?
      render json: {
        data: {
          errors: "Couldn't find an item with id: #{params[:item_id]}"
        }
      }, status: :bad_request
      return
    end

    if sale.items.include?(item)
      render json: {
        data: {
          errors: "Item with id: #{item.id} already exists in the sale"
        }
      }, status: :bad_request
      return
    end

    if sale.items << item
      # sale.update(total_price: sale.items.sum(:selling_price))
      update_sale_total(sale)
      render json: {
        operation: "Item with id: #{item.id} added successfully to sale with id: #{params[:id]}"
      }, status: :ok
    else
      render json: {
        data: {
          errors: "Couldn't add Item with id: #{item.id} to sale with id: #{params[:id]}"
        }
      }, status: :bad_request
    end
  end

  # api/v1/sales/:id/items/:item_id
  def update_item
    item = Item.find_by(id: params[:item_id])
    sale = Sale.find_by(id: params[:id])

    if item.nil?
      render json: {
        data: {
          errors: "Couldn't find an item with id: #{params[:item_id]}"
        }
      }, status: :bad_request
      return
    end

    sale_item = sale.items.find(item.id)

    if sale_item.nil?
      render json: {
        data: {
          errors: "Item with id: #{item.id} is not associated with sale with id: #{params[:id]}"
        }
      }, status: :bad_request
      return
    end

    if sale_item.update(item_quantity: params[:item_quantity])
      render json: {
        operation: "Quantity of Item with id: #{item.id} in sale with id: #{params[:id]} updated successfully"
      }, status: :ok
    else
      render json: {
        data: {
          errors: "Couldn't update quantity of Item with id: #{item.id} in sale with id: #{params[:id]}"
        }
      }, status: :bad_request
    end
  end

  # api/v1/sales/:id/items/:item_id
  def delete_item
    item = Item.find_by(id: params[:item_id])
    sale = Sale.find_by(id: params[:id])

    if sale && item
      sale.items.delete(item)
      # sale.update(total_price: sale.items.sum(:selling_price))
      update_sale_total(sale)
      render json: {
        operation: "Item with id #{item.id} has been deleted from sale with id #{sale.id}",
        data: {
          sale_id: sale.id,
          item_id: item.id
        }
      }, status: :ok
    else
      render json: {
        operation: "Couldn't delete item with id #{params[:item_id]} from sale with id #{params[:id]}.",
        data: {
          errors: {
            sale: sale ? 'Item Not Found' : 'Sale Not Found',
            item: item ? 'Sale Not Found' : 'Item Not Found'
          }
        }
      }, status: :not_found
    end
  end

  # api/v1/sales/:id/items/
  def sale_items_data
    sale = Sale.find_by(id: params[:id])

    if sale.nil?
      render json: {
        data: {
          errors: "Couldn't find a sale with id: #{params[:id]}"
        }
      }, status: :not_found
      return
    end

    # items_data = sale.items.map do |item|
    #   {
    #     id: item.id,
    #     name: item.name,
    #     selling_price: item.selling_price,
    #     item_quantity: item.item_quantity,
    #     category: item.category
    #   }
    # end

    #     sale = Sale.find(1)
    # items_sale = sale.items_sales.first
    # item = items_sale.item
    # quantity = items_sale.quantity

    items_data = sale.items.map do |item|
      item_sale = ItemsSale.find_by(item_id: item.id, sale_id: sale.id)
      {
        id: item.id,
        name: item.name,
        selling_price: item.selling_price,
        item_quantity: item.item_quantity,
        quantity: item_sale.quantity,
        category: item.category
      }
    end

    render json: {
      sale_id: sale.id,
      sale: sale,
      items: items_data
    }, status: :ok
  end

  private

  def sale_params
    params.require(:sale).permit(:name, :total_price, :user_id)
  end

  def item_params
    params.require(:item).permit(:name, :buying_price, :selling_price, :item_quantity, :category, :sale_id)
  end

  def item_sale_params
    params.require(:item_sale).permit(:item_id, :sale_id, :quantity)
  end

  def update_sale_total(sale)
    sale.update(total_price: sale.items.sum(:selling_price))
    sale.update(total_items: sale.items.distinct.count(:item_id))

  end
end
