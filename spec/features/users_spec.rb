require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario "Signupページにページ遷移できるか" do
    visit root_url
    click_on "新規ユーザー登録"
    expect(page).to have_content("新規ユーザー登録")
  end

  scenario "ユーザ登録できること" do
    user = FactoryBot.build(:user)
    visit new_user_path
    expect{
      fill_in "user[name]", with: user.name
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      fill_in "user[password_confirmation]", with: user.password_confirmation
      click_button "ユーザー登録"
    }.to change(User, :count).to(1)
  end

  scenario "エラーメッセージが正しく表示される" do
    user = FactoryBot.build(:user)
    visit new_user_path
    fill_in "user[name]", with: " "
    fill_in "user[email]", with: " "
    fill_in "user[password]", with: " "
    fill_in "user[password_confirmation]", with: " "
    click_button "ユーザー登録"
    expect(page).to have_content("を入力してください")
  end

end