class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  # カート内商品一覧
  # URL: GET /cart_items
  def index
    @cart_items = current_customer.cart_items.includes(:product)
    @total = @cart_items.sum(&:subtotal)
  end

  # カートに商品を追加
  # URL: POST /cart_items
  def create
    @cart_item = current_customer.cart_items.find_by(product_id: params[:cart_item][:product_id])
    
    if @cart_item
      # 既にカートに同じ商品がある場合は数量を加算
      @cart_item.amount += params[:cart_item][:amount].to_i
      @cart_item.save
      redirect_to cart_items_path, notice: "カートに商品を追加しました"
    else
      # 新しく商品をカートに追加
      @cart_item = current_customer.cart_items.new(cart_item_params)
      if @cart_item.save
        redirect_to cart_items_path, notice: "カートに商品を追加しました"
      else
        redirect_to item_path(params[:cart_item][:product_id]), alert: "カートへの追加に失敗しました"
      end
    end
  end

  # カート内商品の数量を更新
  # URL: PATCH /cart_items/:id
  def update
    @cart_item = current_customer.cart_items.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path, notice: "数量を更新しました"
    else
      redirect_to cart_items_path, alert: "更新に失敗しました"
    end
  end

  # カート内商品を削除（1商品）
  # URL: DELETE /cart_items/:id
  def destroy
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path, notice: "商品をカートから削除しました"
  end

  # カート内商品を全削除
  # URL: DELETE /cart_items/destroy_all
  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path, notice: "カートを空にしました"
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :amount)
  end
end
