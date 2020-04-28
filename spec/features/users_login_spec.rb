require 'rails_helper'
RSpec.feature "UsersLogin", type: :feature do
  before do
    @user = FactoryBot.create(:user)
  end

  scenario "ログインした後にメニューバーの表示内容が変わること" do
    visit login_path
    fill_in "session[email]", with: @user.email
    fill_in "session[password]", with: @user.password
    click_button "ログイン"
    expect(page).to_not have_css("a", text: "ログイン")
    expect(page).to have_css("a", text: "ログアウト")
    expect(page).to have_css("a", text: "投稿")
  end

end