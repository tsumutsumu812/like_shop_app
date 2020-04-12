require 'rails_helper'

RSpec.describe "UsersLoginApi", type: :request do
  it "ログインページへアクセス可能である" do
    get login_path
    expect(response).to have_http_status(:success)
  end 

  describe "<session#new>" do
    context "ログインに失敗した時" do
      it "フラッシュの残留をキャッチ" do
        get login_path
        post login_path, params: { session: { email: "", password: "" }}
        expect(flash[:danger]).to be_truthy
        get root_path
        expect(flash[:danger]).to be_falsey
      end
    end
  end

end