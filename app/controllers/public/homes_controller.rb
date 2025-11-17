class Public::HomesController < ApplicationController
  # トップページ
  def top
    @products = Product.where(is_active: true).limit(4)
  end

  # アバウトページ
  def about
  end
end
