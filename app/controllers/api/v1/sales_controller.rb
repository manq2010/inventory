class Api::V1::SalesController < ApplicationController
  # before_action :set_sale, only: %i[show destroy]
  skip_before_action :authenticate

  def index
    # @sales = Sale.all
    # render json: @sales

    list_sales = Sale.includes(item: [:images])
      .where(user_id: current_user_id).as_json(include: { item: {
                                                 only: %i[
                                                   name selling_price quantity category images
                                                 ], include: :images
                                               } })

    render json: {
      data: {
        sales: list_sales
      }
    }, status: :ok
  end

  def show
    render json: @sale
  end

  def create
    # sale = Sale.new(sale_params)

    # if @sale.save
    #   render json: @sale, status: :created
    # else
    #   render json: @sale.errors, status: :unprocessable_entity
    # end

    sale = Sale.new(sale_params.merge(user_id: current_user_id))

    if sale.save
      # id = sale.id

      # @images = params[:images].map do |image|
      #   { url: image, item_id: id }
      # end

      # Image.insert_all(@images)
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

  def destroy
    @sale.destroy
    head :no_content
  end

  private

  # def set_sale
  #   @sale = Sale.find(params[:id])
  # end

  def sale_params
    params.require(:sale).permit(:name, :total_price)
  end
end
