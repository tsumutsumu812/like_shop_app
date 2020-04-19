require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "ユーザー登録ページの表示に成功すること" do
      get :new
      expect(response).to have_http_status "200"
    end
  end

  describe "GET #index" do
    it "ユーザー一覧ページの表示に成功すること" do
      get :index
      expect(response).to have_http_status "200"
    end
  end

  describe "GET #show" do
    before do
      @user = FactoryBot.create(:user)
    end
    
    it "未ログインでも他のユーザーの詳細画面に遷移できること" do
      get :show, params: { id: @user.id }
      expect(response).to have_http_status "200"
    end
  end

  describe "GET #edit" do
    before do
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:user, name: "other", email: "other@gmail.com")
    end
    context "ログインしているとき時" do
      it "自分のユーザー情報編集画面に遷移できること" do
        log_in @user
        get :edit, params: { id: @user.id }
        expect(response).to have_http_status "200"
      end
    end
    context "未ログインで編集ページへアクセス時" do
      it "302ステータスが返ってくること" do
        get :edit, params: { id: @user.id }
        expect(response).to have_http_status "302"
      end
      it "ログイン画面へ遷移すること" do
        get :edit, params: { id: @user.id }
        expect(response).to redirect_to login_path
      end
    end
    context "ログイン時に他のユーザーの編集ページにアクセス時" do
      before do
        log_in @user
      end
      it "302ステータスが返ってくること" do
        get :edit, params: { id: @other_user.id }
        expect(response).to have_http_status "302"
      end
      it "投稿一覧画面へ遷移すること" do
        get :edit, params: { id: @other_user.id }
        expect(response).to redirect_to shops_path
      end
    end
  end

  describe "#following" do
    before do
      @user = FactoryBot.create(:user)
    end
    context "未ログインユーザーがフォロー一覧へアクセス時" do
      it "302ステータスが返ってくること" do
        get :following, params: { id: @user.id }
        expect(response).to have_http_status "302"
      end
      it "ログインページにリダイレクトされること" do
        get :following, params: { id: @user.id }
        expect(response).to redirect_to login_path
      end
    end
    context "ログイン状態でタイムラインページへのアクセス時" do
      it "フォロー一覧の表示に成功すること" do
        log_in @user
        get :following, params: { id: @user.id }
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "#followers" do
    before do
      @user = FactoryBot.create(:user)
    end
    context "未ログインユーザーがフォロワー一覧へアクセス時" do
      it "302ステータスが返ってくること" do
        get :followers, params: { id: @user.id }
        expect(response).to have_http_status "302"
      end
      it "ログインページにリダイレクトされること" do
        get :followers, params: { id: @user.id }
        expect(response).to redirect_to login_path
      end
    end
    context "ログイン状態でタイムラインページへのアクセス時" do
      it "フォロー一覧の表示に成功すること" do
        log_in @user
        get :followers, params: { id: @user.id }
        expect(response).to have_http_status "200"
      end
    end
  end
 
    

  describe "error message check" do
    it "空白チェック" do
        user = User.new()
        user.valid?
        expect(user.errors.messages[:name]).to include("を入力してください")
    end
  end

end
