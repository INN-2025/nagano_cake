require "rails_helper"

RSpec.describe OrderDetail, type: :model do
  before do
    customer = Customer.new(
      last_name: "山田", first_name: "太郎",
      last_name_kana: "ヤマダ", first_name_kana: "タロウ",
      postal_code: "1234567", address: "大阪市",
      telephone_number: "08000000000"
    )

    order = Order.new(
      customer: customer,
      postal_code: "1234567",
      address: "大阪市中央区",
      name: "山田太郎",
      shipping_cost: 800,
      total_payment: 2000
    )

    product = Product.new(
      name: "ショートケーキ",
      introduction: "美味しいケーキです",
      price: 500,
      is_active: true,
      genre: Genre.new(name: "ケーキ")
    )

    @order_detail = OrderDetail.new(
      order: order,
      product: product,
      amount: 2,
      price: 500,
      making_status: :cannot_start
    )
  end

  describe "バリデーションのテスト" do
    it "amountが空なら無効" do
      @order_detail.amount = nil
      expect(@order_detail).to_not be_valid
    end
  end
end