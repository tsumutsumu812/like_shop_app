require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  let(:user) do
    FactoryBot.build(:user)
  end

  context "全ての値が正常に入っている時" do
    it "バリデーションに成功すること" do
      expect(user).to be_valid
    end
  end

  context "名前が空の時" do
    it "バリデーションエラーが発生すること" do
      user.name=" "
      user.valid?
      expect(user.errors[:name]).to include("を入力してください") 
    end
  end

  context "メールアドレスが記入されていない時" do
    it "バリデーションエラーが発生すること" do
      user.email = " "
      expect(user).to be_invalid
    end
    it "エラー文が表示されること" do
      user.email = " "
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
  end

  context "メールアドレスが一意の値にならない時" do
    it "バリデーショネラーが発生すること" do
      duplicate_user = user.dup
      duplicate_user.email = user.email
      user.save!
      expect(duplicate_user).to be_invalid
    end
  end

  context "自己紹介が255字以上の時" do
    it "バリデーションエラーが発生すること" do
      user.introduction = "a" * 257
      expect(user).to be_invalid
      user.introduction = "a" * 256
      expect(user).to be_valid
    end
  end
  
  it "パスワードが空白になっていないか" do
    user.password = user.password_confirmation = "a"*6
    expect(user).to be_valid
    user.password = user.password_confirmation = "  "*6
    expect(user).to be_invalid
  end

  describe "password length" do
    context "パスワードが6桁のとき" do
      it "正しい" do
        user = FactoryBot.build(:user, password: "a"*6, password_confirmation: "a"*6)
        expect(user).to be_valid
      end
    end

    context "パスワードが5桁のとき" do
      it "正しくない" do
        user = FactoryBot.build(:user, password: "a*5", password_confirmation: "a" * 5)
        expect(user).to be_invalid
      end
    end
  end

end
