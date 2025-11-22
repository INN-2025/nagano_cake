class Product < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  
  # Active Storage
  has_one_attached :image
  
  # バリデーション
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :is_active, inclusion: { in: [true, false] }
  
  # is_activeはboolean型なので、enumは使わない
  # active? と inactive? メソッドを定義
  def active?
    is_active == true
  end
  
  def inactive?
    is_active == false
  end
  
  # スコープ
  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }
  
  # 税込価格を計算
  def with_tax_price
    (price * 1.1).floor
  end
end
