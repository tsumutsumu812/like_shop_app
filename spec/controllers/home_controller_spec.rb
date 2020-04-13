require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "#top" do
    context "トップページへのアクセス時" do
      it "トップページの表示に成功すること" do
        get :top
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "#timeline" do
    context "未ログインユーザーがタイムラインページへのアクセス時" do
      it "302ステータスが返ってくること" do
        get :timeline
        expect(response).to have_http_status "302"
      end
      it "ログインページにリダイレクトされること" do
        get :timeline
        expect(response).to redirect_to login_path
      end
    end

    context "ログイン状態でタイムラインページへのアクセス時" do
      before do
        @user = FactoryBot.create(:user)

      end
      it "タイムラインページの表示に成功すること" do
        log_in @user
        get :timeline
        expect(response).to have_http_status "200"
      end
    end
  end

end