require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    customer = Customer.new(
      last_name: "山田",
      first_name: "太郎",
      last_name_kana: "ヤマダ",
      first_name_kana: "タロウ",
      postal_code: "1234567",
      address: "大阪市",
      telephone_number: "08000000000"
    )

    @order = Order.new(
      customer: customer,
      postal_code: "1234567",
      address: "大阪市中央区",
      name: "山田太郎",
      shipping_cost: 800,
      total_payment: 2000
    )
  end

   describe "バリデーションのテスト" do
    it "postal_codeが存在すれば有効" do
      expect(@order).to be_valid
    end

    it "postal_codeが空なら無効" do
      @order.postal_code = ""
      expect(@order).to_not be_valid
    end

    it "addressが空なら無効" do
      @order.address = ""
      expect(@order).to_not be_valid
    end

    it "nameが空なら無効" do
      @order.name = ""
      expect(@order).to_not be_valid
    end

    it "shipping_costが空なら無効" do
      @order.shipping_cost = nil
      expect(@order).to_not be_valid
    end

    it "total_paymentが空なら無効" do
      @order.total_payment = nil
      expect(@order).to_not be_valid
    end
  end
end