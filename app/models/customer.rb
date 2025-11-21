class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, :first_name, :last_name_kana, :first_name_kana,
            :postal_code, :address, :telephone_number, presence: true
  
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy   
end