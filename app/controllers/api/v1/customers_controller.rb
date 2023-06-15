class Api::V1::CustomersController < ApplicationController
  # skip_before_action :authenticate

  def index
    customers = Customer.all
    render json: { data: { customers: customers } }, status: :ok
  end

  def show
    customer = Customer.find_by(id: params[:id])

    if customer
      render json: { data: { customer: customer } }, status: :ok
    else
      render json: { data: { errors: "Couldn't find a customer with id: #{params[:id]}" } }, status: :bad_request
    end
  end

  def create
    customer = Customer.new(customer_params)

    if customer.save
      render json: { operation: "Customer created successfully with id: #{customer.id}", data: { customer_id: customer.id } },
             status: :created
    else
      render json: { operation: 'Not successful', data: { errors: customer.errors } }, status: :bad_request
    end
  end

  def update
    customer = Customer.find(params[:id])

    if customer.update(customer_params)
      render json: { operation: "Customer updated successfully with id: #{customer.id}", data: { customer_id: customer.id } },
             status: :ok
    else
      render json: { operation: 'Not successful', data: { errors: customer.errors } }, status: :bad_request
    end
  end

  def destroy
    customer = Customer.find_by(id: params[:id])

    if customer&.destroy
      render json: { operation: "Customer deleted with id #{customer.id}" }, status: :accepted
    else
      render json: { operation: "Couldn't delete customer with id #{params[:id]}.", data: { errors: { customer: 'Not Found' } } },
             status: :not_found
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :country_code, :address)
  end
end
