class Order < ApplicationRecord

  enum status: {
  before_payment: 0,
  confirmed_payment: 1,
  making: 2,
  ready_for_shipment: 3,
  shipped: 4
}

  def status_i18n
    I18n.t("enums.order.status.#{status}")
  end


  belongs_to :customer
  has_many :order_details

  def total
    order_details.sum { |detail|detail.price * detail.amount }
  end

  def billing_amount
    shipping_cost + total
  end
end
