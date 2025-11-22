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
  
  # 小計を計算
  def subtotal
    price * amount
  end
end

