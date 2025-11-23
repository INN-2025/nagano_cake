class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  after_update :update_making_status, if: :saved_change_to_status?
  
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
  
  # 商品合計金額を計算（税込）
  def total
    order_details.sum(&:subtotal)
  end
  
  # 商品合計（エイリアス）
  def subtotal
    total
  end
  
  # 請求金額を計算（商品合計 + 送料）
  def billing_amount
    shipping_cost + total
  end
  
  # 請求金額（エイリアス）
  def total_amount
    billing_amount
  end

  private

  def update_making_status
    # 注文ステータスが「入金確認」になった時、全OrderDetailを「製作待ち」に更新
    if self.confirmed_payment?
      self.order_details.update_all(making_status: :waiting)
    end
  end

end
