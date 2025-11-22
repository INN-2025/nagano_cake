class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  
  # バリデーション
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :shipping_cost, presence: true
  validates :total_payment, presence: true
  
  # enumで支払方法を管理
  enum payment_method: { credit_card: 0, bank_transfer: 1 }
  
  # enumで注文ステータスを管理
  enum status: { 
    before_payment: 0,      # 入金待ち
    confirmed_payment: 1,   # 入金確認
    making: 2,              # 製作中
    ready_for_shipment: 3,  # 発送準備中
    shipped: 4              # 発送済み
  }
  
  # 日本語の支払方法名を返す
  def payment_method_i18n
    I18n.t("enums.order.payment_method.#{payment_method}")
  end
  
  # 日本語のステータス名を返す
  def status_i18n
    I18n.t("enums.order.status.#{status}")
  end
  
  # 商品合計金額を計算（既存のtotalメソッドと同じ）
  def total
    order_details.sum { |detail| detail.price * detail.amount }
  end
  
  # 商品合計（エイリアス）
  def subtotal
    total
  end
  
  # 請求金額を計算（既存のbilling_amountメソッドと同じ）
  def billing_amount
    shipping_cost + total
  end
  
  # 請求金額（エイリアス）
  def total_amount
    billing_amount
  end
end
