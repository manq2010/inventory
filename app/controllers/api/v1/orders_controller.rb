class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: %i[show change_status destroy]
  # skip_before_action :authenticate

  def index
    # @orders = Order.all
    # render json: @orders

    list_orders = Order.includes(item: [:images])
      .where(user_id: current_user_id).as_json(include: { item: {
                                                 only: %i[
                                                   name selling_price quantity category images
                                                 ], include: :images
                                               } })

    render json: {
      data: {
        orders: list_orders
      }
    }, status: :ok
  end

  def show
    render json: @order
  end

  def create
    order = Order.new(order_params.merge(user_id: current_user_id))

    if order.save
      render json: {
        operation: 'Order created successfully',
        data: {
          order_id: order.id
        }
      }, status: :created
    else
      render json: {
        operation: 'not successful',
        data: {
          errors: order.errors
        }
      }, status: :bad_request
    end

    # @order = Order.new(order_params)

    # if @order.save
    #   render json: @order, status: :created
    # else
    #   render json: @order.errors, status: :unprocessable_entity
    # end
  end

  def change_status
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    head :no_content
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:pic, :total_price, :status)
  end
end
