class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  after_update :update_order_status
  
  # enumで製作ステータスを管理
  enum making_status: {
    cannot_start: 0,    # 着手不可
    waiting: 1,         # 製作待ち
    in_production: 2,   # 製作中
    completed: 3        # 製作完了
  }
  
  # 税込単価を取得（OrderDetail作成時にpriceカラムに保存された価格に対して消費税を適用）
  def price_with_tax
    (price * 1.1).floor
  end
  
  # 小計を計算（税込単価 × 数量）
  def subtotal
    price_with_tax * amount
  end

  private

  def update_order_status
    order = self.order

    # 製作ステータスが「製作中」になったら 注文ステータスも「製作中」にする
    if self.making_status == "in_production"
      order.update(status: :making)
    end

    # 全ての製作ステータスが「製作完了」なら 注文ステータスを「発送準備中」にする
    if order.order_details.all? { |d| d.making_status == "completed" }
      order.update(status: :ready_for_shipment)
    end
  end
end

