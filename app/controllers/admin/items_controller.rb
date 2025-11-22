class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_item, only: [:show, :edit, :update]

  # 商品一覧
  def index
    @items = Product.includes(:genre).page(params[:page]).per(10)
  end

  # 商品新規登録画面
  def new
    @item = Product.new
    @genres = Genre.where(is_active: true)
  end

  # 商品登録処理
  def create
    @item = Product.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item), notice: '商品を登録しました。'
    else
      @genres = Genre.where(is_active: true)
      render :new
    end
  end

  # 商品詳細
  def show
  end

  # 商品編集画面
  def edit
    @genres = Genre.where(is_active: true)
  end

  # 商品更新処理
  def update
    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: '商品を更新しました。'
    else
      @genres = Genre.where(is_active: true)
      render :edit
    end
  end

  private

  def set_item
    @item = Product.find(params[:id])
  end

  def item_params
    params.require(:product).permit(:name, :introduction, :price, :image, :is_active, :genre_id)
  end
end
