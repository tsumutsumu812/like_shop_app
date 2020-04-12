require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
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
