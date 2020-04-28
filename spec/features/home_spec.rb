require 'rails_helper'

RSpec.feature "Home", type: :feature do 
  describe 'TOP' do
    before { visit home_top_url}
    context 'トップ画面への遷移時' do
      it 'トップ画面の表示' do
        expect(page).to have_css('h1', text: 'YouLike')
      end
      it 'タイトル内容の表示' do
        expect(page).to have_title 'トップ-YouLike'
      end
      scenario "topへページ遷移できるか" do
        click_link "Home"  
        expect(page).to have_content("YouLike")
      end
      scenario "店一覧へページ遷移できるか" do
        click_link "投稿一覧"  
        expect(page).to have_content("投稿一覧")
      end
      scenario "ログインへページ遷移できるか" do
        click_link "ログイン", match: :first
        expect(page).to have_content("ログイン")
      end
      scenario "ユーザ登録へページ遷移できるか" do
        click_link "新規ユーザー登録", match: :first 
        expect(page).to have_content("新規ユーザー登録")
      end
    end

  end

  describe 'Root' do
    before { visit root_url }
    context 'ルートパスへの遷移時' do
      it 'トップ画面の表示' do
        expect(page).to have_css('h1', text: 'YouLike')
      end
      it 'タイトル内容の表示' do
        expect(page).to have_title 'トップ-YouLike'
      end
    end
  end
end
  


