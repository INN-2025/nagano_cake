class Order < ApplicationRecord

  enum status:  [ :before_payment, :confirmed_payment, :making, :ready_for_shipment, :shipped]

  belongs_to :customer
  has_many :order_details

  def total
    order_details.sum { |detail|detail.price * detail.amount }
  end

  def billing_amount
    shipping_cost + total
  end
end
