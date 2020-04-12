require "rails_helper"

RSpec.describe "UsersApi", type: :request do
  let(:params){
    {name: "testuser1", email:"test@gmail.com", password: "password", password_confirmation: "password" }
  }

  before do
    get new_user_path
  end

  describe "users#<create>" do
    it "postデータの受け取りができること" do
      post users_path, params: {user: params}
      expect(response).to have_http_status(302)
    end
  end

end