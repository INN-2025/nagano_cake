require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    genre = Genre.create!(name: "ケーキ")  

    @product = Product.new(
      name: "ショートケーキ",
      introduction: "美味しいケーキです",
      price: 500,
      is_active: true,
      genre: genre        
    )
  end

  describe "バリデーションのテスト" do
    it "nameが存在すれば有効" do
      expect(@product).to be_valid
    end

    it "nameが空の場合は無効" do
      @product.name = ""
      expect(@product).to_not be_valid
    end

    it "priceが空の場合は無効" do
      @product.price = nil
      expect(@product).to_not be_valid
    end
    it "introductionが空の場合は無効" do
     @product.introduction = ""
     expect(@product).to_not be_valid
    end

    it "priceが数値でなければ無効" do
      @product.price = "aaa"
      expect(@product).to_not be_valid
    end

    it "priceが0未満は無効" do
      @product.price = -1
      expect(@product).to_not be_valid
    end
  end
end