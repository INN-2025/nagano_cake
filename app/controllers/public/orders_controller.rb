class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
    @addresses = current_customer.addresses

    # 必須チェック
    if params[:order].nil? || params[:order][:payment_method].blank?
      flash.now[:alert] = "支払い方法を選択してください"
      return render :new
    end

    if params[:order].nil? || params[:order][:address_option].blank?
      flash.now[:alert] = "お届け先を選択してください"
      return render :new
    end
    
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.payment_method = params[:order][:payment_method]
    
    address_option = params[:order][:address_option]

    if address_option == "own"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

    elsif address_option == "registered"
      address = Address.find(params[:order][:registered_address_id])
      @order.postal_code = address.postal_code
      @order.address = address.address
      @order.name = address.name

    elsif address_option == "new"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end

    @cart_items = current_customer.cart_items
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_cost = 800
    
    # カートの商品合計（税込）を計算
    cart_total = current_customer.cart_items.sum(&:subtotal)
    @order.total_payment = cart_total + 800  # 商品合計 + 送料
    
    if @order.save
      # OrderDetailを作成（税込価格を保存）
      current_customer.cart_items.each do |cart_item|
        OrderDetail.create!(
          order_id: @order.id,
          product_id: cart_item.product_id,
          amount: cart_item.amount,
          price: cart_item.product.with_tax_price  # ← ✅ 税込価格！
        )
      end

      # カートを空にする
      current_customer.cart_items.destroy_all
      redirect_to thanks_orders_path
    else
      flash[:alert] = "注文に失敗しました"
      redirect_to new_order_path
    end
  end

  def thanks
  end

  def index
     @orders = current_customer.orders.order(created_at: :desc)
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
