class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product



  def subtotal
    price * amount
  end

end

