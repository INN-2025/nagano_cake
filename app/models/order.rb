class Order < ApplicationRecord

  enum status:  [ "入金待ち", "入金確認", "製作中", "発送準備中", "発送済み" ]

  belongs_to :customer
  has_many :order_details

  def total
    order_details.sum { |detail|detail.price * detail.amount }
  end

  def billing_amount
    shipping_cost + total
  end
end
