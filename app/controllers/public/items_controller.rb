class Public::ItemsController < ApplicationController
  # 商品一覧
  # モデル: Product
  # URL: GET /items
  def index
    @genres = Genre.where(is_active: true)
    @products = Product.where(is_active: true).includes(:genre).page(params[:page])
    
    # ジャンル絞り込み
    if params[:genre_id].present?
      @products = @products.where(genre_id: params[:genre_id])
    end
  end

  # 商品詳細
  # モデル: Product
  # URL: GET /items/:id
  def show
    @product = Product.find(params[:id])
    # @cart_item = CartItem.new  # カートアイテムの初期化
    @genres = Genre.where(is_active: true)
  end
end
