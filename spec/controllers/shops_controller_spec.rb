require 'rails_helper'

RSpec.describe ShopsController, type: :controller do
  describe "GET #new" do
    before do
      @user = FactoryBot.create(:user)
    end
    context "ログインしているとき時" do
      it "店舗新規投稿ページにアクセスできること" do
        log_in @user
        get :new
        expect(response).to have_http_status "200"
      end
    end

    context "未ログインで店舗新規投稿ページへアクセス時" do
      it "302ステータスが返ってくること" do
        get :new
        expect(response).to have_http_status "302"
      end
      it "ログイン画面へ遷移すること" do
        get :new
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET #index" do
    it "店舗一覧ページの表示に成功すること" do
      get :index
      expect(response).to have_http_status "200"
    end
  end

  describe "GET #show" do
    before do
      @shop = FactoryBot.create(:shop)
    end
    it "未ログインでも店舗の詳細画面に遷移できること" do
      get :show, params: { id: @shop.id }
      expect(response).to have_http_status "200"
    end
  end

  describe "GET #edit" do
    before do
      @user = FactoryBot.create(:user)  
      @other_user = FactoryBot.create(:user)  
      @shop = @user.shops.create(name: "ショップ1")
      @other_shop = @other_user.shops.create(name: "ショップ2")
    end
    context "未ログインで編集ページへアクセス時" do  
      it "302ステータスが返ってくること" do
        get :edit, params: { id: @shop.id }
        expect(response).to have_http_status "302"
      end
      it "ログイン画面へ遷移すること" do
        get :edit, params: { id: @shop.id }
        expect(response).to redirect_to login_path
      end
    end
    context "ログインしているとき時" do
      it "自分のユーザー情報編集画面に遷移できること" do
        log_in @user
        get :edit, params: { id: @shop.id }
        expect(response).to have_http_status "200"
      end
    end
    context "ログイン時に他のユーザーの編集ページにアクセス時" do
      before do
        log_in @user
      end
      it "302ステータスが返ってくること" do
        get :edit, params: { id: @other_shop.id }
        expect(response).to have_http_status "302"
      end
      it "投稿一覧画面へ遷移すること" do
        get :edit, params: { id: @other_shop.id }
        expect(response).to redirect_to shops_path
      end
    end
  end

end