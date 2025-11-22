class CartItem < ApplicationRecord
  # アソシエーション
  belongs_to :customer
  belongs_to :product

  # バリデーション
  validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0 }

  # 小計を計算するメソッド
  def subtotal
    product.price * amount
  end
end
