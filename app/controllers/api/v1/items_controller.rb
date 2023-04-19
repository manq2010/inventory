class Api::V1::ItemsController < ApplicationController
 # api/v1/items
  def index
    # @items = Item.all
    # render json: @items
    list_items = Item.includes(:images)
    render json: {
      data: {
        items: list_items.as_json(include: :images)
      }
    }, status: :ok
  end

  # api/v1/items/{id}
  def show
    # render json: @item
    item = Item.find_by(id: params[:id]).as_json(include: :images)
    if car
      render json: {
        data: {
          items: item
        }
      }, status: :ok
    else
      render json: {
        data: {
          items: item,
          errors: "Couldn't find a item with id: #{params[:id]}"
        }
      }, status: :bad_request
    end
  end

  # api/v1/items
  def create
    # @item = Item.new(item_params)

    # if @item.save
    #   render json: @item, status: :created
    # else
    #   render json: @item.errors, status: :unprocessable_entity
    # end
    # item = Item.new(car_params.merge(user_id: current_user_id))
    
    item = Item.new(item_params)

    if item.save
      id = item.id

      @images = params[:images].map do |image|
        { url: image, item_id: id }
      end

      Image.insert_all(@images)
      render json: {
        operation: "Item created successfully with id: #{id}",
        data: {
          item_id: id
        }
      }, status: :created
    else
      render json: {
        operation: 'Not successful',
        data: {
          errors: item.errors
        }
      }, status: :bad_request
    end
  end

  # api/v1/items/{id}
  def update
    # if @item.update(item_params)
    #   render json: @item
    # else
    #   render json: @item.errors, status: :unprocessable_entity
    # end

    # NB: take the create function and use it to update
  end

  # api/v1/items/{id}
  def destroy
    # @item.destroy
    # head :no_content

    item = Item.find_by(id: params[:id], user_id: current_user_id)

    if item&.destroy
      render json: { operation: "Car deleted with id #{item.id}" }, status: :accepted
    else
      render json: {
        operation: "Couldn't delete item with id #{params[:id]}.",
        data: {
          errors: {
            item: 'Not Found'
          }
        }
      }, status: :not_found
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :buying_price, :selling_price, :quantity, :category, :images)
  end
end
