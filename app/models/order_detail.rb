class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product
  
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
end

