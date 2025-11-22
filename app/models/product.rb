class Product < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  
  # Active Storageで画像を添付
  has_one_attached :image
  
  # バリデーション
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :genre_id, presence: true
  
  # is_activeのenum設定（0: 販売停止中, 1: 販売中）
  enum is_active: { inactive: 0, active: 1 }
  
  # 税込価格を計算
  def with_tax_price
    (price * 1.1).floor
  end
end
