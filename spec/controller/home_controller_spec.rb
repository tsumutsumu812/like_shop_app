require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "#top" do
    it "topページのアクセスに成功すること" do
      get :top
      expect(response).to have_http_status "200"
    end
  end
end