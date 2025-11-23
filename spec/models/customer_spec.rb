require 'rails_helper'

RSpec.describe Customer, type: :model do
  before do
    @customer = Customer.new(
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
  end

  describe "バリデーションのテスト" do
    it "すべての項目が存在すれば有効" do
      expect(@customer).to be_valid
    end

    it "last_nameが空なら無効" do
      @customer.last_name = ""
      expect(@customer).to_not be_valid
    end

    it "first_nameが空なら無効" do
      @customer.first_name = ""
      expect(@customer).to_not be_valid
    end

    it "last_name_kanaが空なら無効" do
      @customer.last_name_kana = ""
      expect(@customer).to_not be_valid
    end

    it "first_name_kanaが空なら無効" do
      @customer.first_name_kana = ""
      expect(@customer).to_not be_valid
    end

    it "postal_codeが空なら無効" do
      @customer.postal_code = ""
      expect(@customer).to_not be_valid
    end

    it "addressが空なら無効" do
      @customer.address = ""
      expect(@customer).to_not be_valid
    end

    it "telephone_numberが空なら無効" do
      @customer.telephone_number = ""
      expect(@customer).to_not be_valid
    end
  end
end