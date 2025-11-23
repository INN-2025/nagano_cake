require 'rails_helper'

RSpec.describe CartItem, type: :model do
  before do
    genre = Genre.create!(name: "ケーキ")
    product = Product.create!(
      name: "ショートケーキ",
      introduction: "おいしいケーキ",
      price: 500,
      is_active: true,
      genre: genre
    )
    customer = Customer.create!(
      last_name: "田中",
      first_name: "太郎",
      last_name_kana: "タナカ",
      first_name_kana: "タロウ",
      postal_code: "1234567",
      address: "東京都渋谷区1-2-3",
      telephone_number: "09011112222",
      email: "test@example.com",
      password: "password"
    )

    @cart_item = CartItem.new(
      amount: 1,
      product: product,
      customer: customer
    )
  end

  describe "バリデーションのテスト" do
    it "amountが存在すれば有効" do
      expect(@cart_item).to be_valid
    end

    it "amountが空なら無効" do
      @cart_item.amount = ""
      expect(@cart_item).to_not be_valid
    end

    it "amountが数値でなければ無効" do
      @cart_item.amount = "aaa"
      expect(@cart_item).to_not be_valid
    end

    it "amountが0以下なら無効" do
      @cart_item.amount = 0
      expect(@cart_item).to_not be_valid
    end
  end
end