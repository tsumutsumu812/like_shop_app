require 'rails_helper'

RSpec.feature "Shops", type: :feature do
  before do
    @user = FactoryBot.create(:user)
    visit root_path
    click_link "ログイン", match: :first
    fill_in "session[email]", with: @user.email
    fill_in "session[password]", with: @user.password
    click_button "ログイン"
  end
  scenario "ユーザーが新しい店を投稿する" do
    expect{
      click_link "投稿"
      fill_in "shop[name]", with: "原宿ショップ"
      fill_in "shop[description]", with: "とてもいい店"
      click_button "投稿する"

      expect(page). to have_content "原宿ショップを追加しました。"

    }.to change(@user.shops, :count).by(1)
  end

  scenario "エラーメッセー時の表示" do
    click_link "投稿"
    fill_in "shop[name]", with: " "
    click_button "投稿する"
    expect(page). to have_content "名前を入力してください"

  end
end