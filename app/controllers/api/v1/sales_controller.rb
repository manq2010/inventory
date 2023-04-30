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
end
