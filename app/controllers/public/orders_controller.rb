class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.payment_method = params[:order][:payment_method]
    address_option = params[:order][:address_option]
    if address_option == "own"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif address_option == "new"
      @order.postal_code = params[:order][:postal_code]
      @order.address     = params[:order][:address]
      @order.name        = params[:order][:name]
    end
    @cart_items = current_customer.cart_items
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_cost = 800

    @order.total_payment = @order.billing_amount
    
    @order.save

    current_customer.cart_items.each do |cart_item|
      OrderDetail.create(order_id: @order.id,product_id:cart_item.product_id,amount: cart_item.amount,price: cart_item.product.price)
  end

  current_customer.cart_items.destroy_all
    redirect_to thanks_orders_path
  end

  def thanks
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  private

  def order_params

  params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end
end
