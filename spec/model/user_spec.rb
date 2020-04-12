require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  let(:user) do
    FactoryBot.build(:user)
  end

  context "when use is valid" do
    it "値が入っている" do
      expect(user).to be_valid
    end
    it "値が入っていない" do
      user.email = " "
      expect(user).to be_invalid
    end
  end

  context "when email address should be unique" do
    it "一意の値となるか" do
      duplicate_user = user.dup
      duplicate_user.email = user.email
      user.save!
      expect(duplicate_user).to be_invalid
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
