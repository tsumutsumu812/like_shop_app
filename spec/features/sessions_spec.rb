require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  before do
    @user = FactoryBot.create(:user)
  end
  describe "セッションログアウトが成功すること" do
    before do
      visit login_path
      fill_in "session[email]", with: @user.email
      fill_in "session[password]", with: @user.password
      click_button "ログイン"
    end
    scenario "ログアウト後にメニューバーの表示が変わる" do
      visit root_path
      click_link "ログアウト"
      expect(page).to have_current_path(root_path)
      expect(page).to have_css("a", text: "ログイン")
      expect(page).to_not have_css("a", text: "ログアウト")
      expect(page).to_not have_css("a", text: "ユーザー検索")
    end 
  end
end