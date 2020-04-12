require 'rails_helper'

RSpec.describe "HomeApi", type: :request do
  describe "GET path check" do
    it "HomeページのHTTPリクエストは正しい" do
      get root_path
      expect(response).to have_http_status(200)
    end
    it "店一覧ページへのHTTPリクエストは正しい" do
      get shops_path 
      expect(response).to have_http_status(200)
    end
    it "ログインページへのHTTPリクエストは正しい" do
      get login_path 
      expect(response).to have_http_status(200)
    end
    it "ユーザー登録ページへのHTTPリクエストは正しい" do
      get new_user_path 
      expect(response).to have_http_status(200)
    end
  end
end