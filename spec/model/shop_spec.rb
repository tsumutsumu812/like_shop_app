require 'rails_helper'

RSpec.describe Shop, type: :model do
  before do 
    @shop = FactoryBot.build(:shop) 
  end
  let(:shop) do
    FactoryBot.build(:shop)
  end

  describe "バリデーションテスト" do
    context "名前が空の時" do
      it "バリデーションエラーが発生すること" do
        shop.name = "  "
        shop.valid?
        expect(shop.errors[:name]).to include("を入力してください")
      end
    end
    context "エリアが10文字以上の時" do
      it "バリデーションエラーが発生すること" do
        shop.area = "a"*11
        shop.valid?
        expect(shop).to be_invalid 
      end
    end
    context "ジャンルが10文字以上の時" do
      it "バリデーションエラーが発生すること" do
        shop.genre = "a"*11
        shop.valid?
        expect(shop).to be_invalid 
      end
    end
    context "住所が10文字以上の時" do
      it "バリデーションエラーが発生すること" do
        shop.address = "a"*51
        shop.valid?
        expect(shop).to be_invalid 
      end
    end
    context "お気に入りが10文字以上の時" do
      it "バリデーションエラーが発生すること" do
        shop.likey = "a"*51
        shop.valid?
        expect(shop).to be_invalid 
      end
    end
    context "詳細説明が10文字以上の時" do
      it "バリデーションエラーが発生すること" do
        shop.description = "a"*501
        shop.valid?
        expect(shop).to be_invalid 
      end
    end
  end
end


