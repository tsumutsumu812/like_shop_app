require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #new" do
    context "未ログイン状態の時" do
      it "ログイン画面の表示に成功すること" do
        get :new
        expect(response).to have_http_status "200"
      end
    end
    context "ログイン状態の時" do
      before{
        @user = FactoryBot.create(:user)
        log_in @user
      }
      it "302ステータスが返ってくること" do
        get :new
        expect(response).to have_http_status "302"
      end
      it "店舗一覧画面にリダイレクトすること" do
        get :new
        expect(response).to redirect_to shops_path
      end
    end
  end
end
