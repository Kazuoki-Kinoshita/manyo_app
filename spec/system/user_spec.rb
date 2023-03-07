require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user2) }

  describe '一般ユーザ登録機能' do
    context 'ユーザが新規作成した場合' do
      it '新規作成したユーザのアカウント詳細画面に表示される' do
        visit new_user_path
        fill_in '名前', with: 'new_name'
        fill_in 'メールアドレス', with: 'new@yahoo.co.jp'
        fill_in 'パスワード', with: 'new1new1'
        fill_in '確認用パスワード', with: 'new1new1'
        click_button '登録する'
        expect(page).to have_content 'ユーザ登録しました！'
        expect(page).to have_content 'アカウント詳細'
        expect(page).to have_content 'new_name'
        expect(page).to have_content 'new@yahoo.co.jp'
      end
    end
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移され、ログイン画面が表示される' do
        visit root_path
        expect(page).to have_content 'ログイン画面'
      end
    end
  end

  describe 'セッション機能' do
    before do
      visit new_session_path
      fill_in 'メールアドレス', with: user2.email
      fill_in 'パスワード', with: user2.password
      click_button 'ログイン'
    end
    context 'ユーザがログインした場合' do
      it 'ユーザのアカウント詳細画面に飛び「ログイン成功しました！」が表示される' do
        expect(page).to have_content 'アカウント詳細'
        expect(page).to have_content 'ログインに成功しました！'
      end
    end
    context 'ユーザがログインした場合' do
      it 'ユーザのアカウント詳細画面が表示される' do
        expect(page).to have_content user2.name
        expect(page).to have_content user2.email
      end
    end
    context '一般ユーザが他人の詳細画面に飛んだ場合' do
      it 'タスク一覧画面に遷移して表示される' do
        visit user_path(user.id)
        expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ログアウトした場合' do
      it 'ログイン画面に戻り「ログアウトしました！」が表示される' do
        click_on 'ログアウト'
        expect(page).to have_content 'ログイン画面'
        expect(page).to have_content 'ログアウトしました！'
      end
    end
  end

  describe '管理画面機能(管理ユーザ)' do
    before do
      visit new_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      click_on '管理者画面はこちら'
    end
    context '管理ユーザが「管理者画面はこちら」にアクセスした場合' do
      it '管理画面のユーザ一覧が表示される' do  
        expect(page).to have_content '管理画面のユーザ一覧画面'
      end
    end
    context '管理ユーザがユーザの新規登録をした場合' do
      it '作成したユーザが管理画面のユーザ一覧画面の一番上に表示される' do
        click_on 'ユーザ新規登録'
        fill_in '名前', with: 'new_user_from_admin'
        fill_in 'メールアドレス', with: 'new_user@yahoo.co.jp'
        fill_in 'パスワード', with: "newuseratadmin"
        fill_in '確認用パスワード', with: "newuseratadmin"
        select 'なし', from: '管理者権限'
        click_button '登録する'      
        new_user = all('.user_row tr')[0]
        expect(new_user).to have_content 'new_user_from_admin'
      end
    end
    context '管理ユーザがユーザの詳細画面にアクセスをした場合' do
      it 'ユーザのアカウント詳細画面が表示される' do
        click_link 'user2'
        expect(page).to have_content 'アカウント詳細'
        expect(page).to have_content 'user2'
        expect(page).to have_content '件のタスクがあります'
        expect(page).to have_content 'タスク名'
      end
    end
    context '管理ユーザがユーザの編集をした場合' do
      it '編集したユーザが管理画面のユーザ画面一覧に表示される' do
        click_on '編集', match: :first
        fill_in '名前', with: 'change_user_name_from_admin'
        fill_in 'メールアドレス', with: 'changeuser@yahoo.co.jp'
        select 'なし', from: '管理者権限'
        click_button '更新する'
        expect(page).to have_content 'change_user_name_from_admin'
      end
    end
    context '管理ユーザがユーザの削除をした場合' do
      it '削除したユーザが管理画面のユーザ画面一覧からなくなって表示される' do
        click_on '削除', match: :first
        expect(page).to_not have_content user2.name
      end
    end
    describe '管理画面機能(一般ユーザ)' do    
      context '一般ユーザが管理画面にアクセスした場合' do
        it 'ログインすると「管理者画面はこちら」ボタンが表示されず、管理画面に直接アクセスすることもできない' do
          visit new_session_path
          fill_in 'メールアドレス', with: user2.email
          fill_in 'パスワード', with: user2.password
          click_button 'ログイン'
          expect(page).to_not have_content '管理者画面はこちら'
          visit admin_users_path
          expect(page).to have_content '管理者以外はアクセスできません！'
        end
      end
    end
  end
end