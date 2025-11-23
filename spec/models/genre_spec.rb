require 'rails_helper'

RSpec.describe Genre, type: :model do
  before do
    @genre = Genre.new(name: "ケーキ")
  end

  describe "バリデーションのテスト" do
    it "nameが存在すれば有効" do
      expect(@genre).to be_valid
    end

    it "nameが空だと無効" do
      @genre.name = ""
      expect(@genre).to_not be_valid
    end

    it "nameが一意であること" do
      @genre.save
      genre2 = Genre.new(name: "ケーキ")
      expect(genre2).to_not be_valid
    end
  end
end