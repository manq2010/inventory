class Api::V1::SalesController < ApplicationController
  # before_action :set_sale, only: %i[show destroy]
  skip_before_action :authenticate
  # before_action :current_user

  def index
    list_sales = Sale.all

    # list_sales = Sale.where(user_id: current_user_id).as_json(include: { item: {
    #                                              only: %i[
    #                                                name selling_price quantity category images
    #                                              ]
    #                                            } })

    render json: {
      data: {
        sales: list_sales
      }
    }, status: :ok
  end

  def show
    sale = Sale.find_by(id: params[:id])
    if sale
      render json: {
        data: {
          sales: sale
        }
      }, status: :ok
    else
      render json: {
        data: {
          errors: "Couldn't find a sale with id: #{params[:id]}"
        }
      }, status: :bad_request
    end
  end

  # api/v1/sales
  def create
    sale = Sale.new(sale_params)
    # sale = Sale.new(sale_params.merge(user_id: current_user_id))

    if sale.save
      id = sale.id

      render json: {
        operation: "Sale created successfully with id: #{id}",
        data: {
          sale_id: id
        }
      }, status: :created
    else
      render json: {
        operation: 'Not successful',
        data: {
          errors: sale.errors
        }
      }, status: :bad_request
    end
  end

  def update
    sale = Sale.find(params[:id])

    if sale.update(sale_params)
      render json: {
        operation: "Sale updated successfully with id: #{sale.id}",
        data: {
          sale_id: sale.id
        }
      }, status: :ok
    else
      render json: {
        operation: 'Not successful',
        data: {
          errors: sale.errors
        }
      }, status: :bad_request
    end
  end

  def destroy
    sale = Sale.find_by(id: params[:id])

    if sale&.destroy
      render json: { operation: "Sale deleted with id #{sale.id}" }, status: :accepted
    else
      render json: {
        operation: "Couldn't delete Sale with id #{params[:id]}.",
        data: {
          errors: {
            sale: 'Not Found'
          }
        }
      }, status: :not_found
    end
  end

  private

  def sale_params
    params.require(:sale).permit(:name, :total_price, :user_id)
  end

  # def item_params
  #   params.require(:item).permit(:name, :buying_price, :selling_price, :item_quantity, :category, :sale_id)
  # end

  # def update_sale_total(sale)
  #   sale.update(total_price: sale.items.sum(:selling_price))
  #   sale.update(total_items: sale.items.distinct.count(:item_id))
  # end
end

# api/v1/sales/:id/items/:item_id
# def update_item

#   sale = Sale.find_by(id: params[:id])
#   item = Item.find(params[:item_id])

#   if sale && item
#     if sale.items.include?(item)
#       if sale.items.update(item_params)
#         render json: {
#           operation: "Item with id #{item.id} has been updated in sale with id #{sale.id}",
#           data: {
#             sale_id: sale.id,
#             item_id: item.id
#           }
#         }, status: :ok
#       else
#         render json: {
#           operation: "Couldn't update item with id #{params[:item_id]} in sale with id #{params[:id]}.",
#           data: {
#             errors: item.errors
#           }
#         }, status: :bad_request
#       end
#     else
#       render json: {
#         operation: "Item with id #{params[:item_id]} doesn't exist in sale with id #{params[:id]}.",
#         data: {
#           errors: {
#             item: 'Not Found in Sale'
#           }
#         }
#       }, status: :not_found
#     end
#   else
#     render json: {
#       operation: "Couldn't update item with id #{params[:item_id]} in sale with id #{params[:id]}.",
#       data: {
#         errors: {
#           sale: sale ? 'Item Not Found' : 'Sale Not Found',
#           item: item ? 'Sale Not Found' : 'Item Not Found'
#         }
#       }
#     }, status: :not_found
#   end

# # api/v1/sales/:id/items/
# def add_item
#   item = Item.find_by(id: params[:item_id])
#   sale = Sale.find_by(id: params[:id])

#   if item.nil?
#     render json: {
#       data: {
#         errors: "Couldn't find an item with id: #{params[:item_id]}"
#       }
#     }, status: :bad_request
#     return
#   end

#   if sale.items.include?(item)
#     render json: {
#       data: {
#         errors: "Item with id: #{item.id} already exists in the sale"
#       }
#     }, status: :bad_request
#     return
#   end

#   if sale.items << item
#     # sale.update(total_price: sale.items.sum(:selling_price))
#     update_sale_total(sale)
#     render json: {
#       operation: "Item with id: #{item.id} added successfully to sale with id: #{params[:id]}"
#     }, status: :ok
#   else
#     render json: {
#       data: {
#         errors: "Couldn't add Item with id: #{item.id} to sale with id: #{params[:id]}"
#       }
#     }, status: :bad_request
#   end
# end

# # api/v1/sales/:id/items/:item_id
# def update_item
#   item = Item.find_by(id: params[:item_id])
#   sale = Sale.find_by(id: params[:id])

#   if item.nil?
#     render json: {
#       data: {
#         errors: "Couldn't find an item with id: #{params[:item_id]}"
#       }
#     }, status: :bad_request
#     return
#   end

#   sale_item = sale.items.find(item.id)

#   if sale_item.nil?
#     render json: {
#       data: {
#         errors: "Item with id: #{item.id} is not associated with sale with id: #{params[:id]}"
#       }
#     }, status: :bad_request
#     return
#   end

#   if sale_item.update(item_quantity: params[:item_quantity])
#     render json: {
#       operation: "Quantity of Item with id: #{item.id} in sale with id: #{params[:id]} updated successfully"
#     }, status: :ok
#   else
#     render json: {
#       data: {
#         errors: "Couldn't update quantity of Item with id: #{item.id} in sale with id: #{params[:id]}"
#       }
#     }, status: :bad_request
#   end
# end

# # api/v1/sales/:id/items/:item_id
# def delete_item
#   item = Item.find_by(id: params[:item_id])
#   sale = Sale.find_by(id: params[:id])

#   if sale && item
#     sale.items.delete(item)
#     # sale.update(total_price: sale.items.sum(:selling_price))
#     update_sale_total(sale)
#     render json: {
#       operation: "Item with id #{item.id} has been deleted from sale with id #{sale.id}",
#       data: {
#         sale_id: sale.id,
#         item_id: item.id
#       }
#     }, status: :ok
#   else
#     render json: {
#       operation: "Couldn't delete item with id #{params[:item_id]} from sale with id #{params[:id]}.",
#       data: {
#         errors: {
#           sale: sale ? 'Item Not Found' : 'Sale Not Found',
#           item: item ? 'Sale Not Found' : 'Item Not Found'
#         }
#       }
#     }, status: :not_found
#   end
# end

# # api/v1/sales/:id/items/
# def sale_items_data
#   sale = Sale.find_by(id: params[:id])

#   if sale.nil?
#     render json: {
#       data: {
#         errors: "Couldn't find a sale with id: #{params[:id]}"
#       }
#     }, status: :not_found
#     return
#   end

#   items_data = sale.items.map do |item|
#     {
#       id: item.id,
#       name: item.name,
#       selling_price: item.selling_price,
#       quantity: item.item_quantity,
#       category: item.category
#     }
#   end

#   render json: {
#     sale_id: sale.id,
#     sale_item: sale.items,
#     sale: sale,
#     items: items_data
#   }, status: :ok
# end

# end
