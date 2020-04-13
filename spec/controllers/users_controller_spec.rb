require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "ユーザー登録ページの表示に成功すること" do
      get :new
      expect(response).to have_http_status "200"
    end
  end

  it "ユーザー一覧ページの表示に成功すること" do
    get :index
    expect(response).to have_http_status "200"
  end

  describe "error message check" do
    it "空白チェック" do
        user = User.new()
        user.valid?
        expect(user.errors.messages[:name]).to include("を入力してください")
    end
  end

end
