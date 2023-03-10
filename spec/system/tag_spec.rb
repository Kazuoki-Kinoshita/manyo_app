require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:task2) { FactoryBot.create(:task2, user: user) }

    before do
      visit new_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"
    end

  describe '新規作成機能' do
    context 'タスクを新規作成した複数のラベルをつけた場合' do
      it 'ラベルをつけたタスクが表示される' do
        visit new_task_path
        fill_in 'タスク名', with: 'new_task'
        fill_in '内容', with: 'new_content'
        fill_in '終了期限', with: Date.new(2023, 5, 4)
        select '完了', from: 'ステータス'
        select '中', from: '優先度'
        check "ラベル1"
        check "ラベル2"
        click_button '登録する'
        expect(page).to have_content 'new_task'
        expect(page).to have_content 'new_content'
        expect(page).to have_content '2023-05-04'
        expect(page).to have_content '完了'
        expect(page).to have_content '中'
        expect(page).to have_content 'ラベル1'
        expect(page).to have_content 'ラベル2'
      end
    end
  end
  describe '検索機能' do
    before do
      visit tasks_path
    end
    context 'ラベルのみで検索した場合' do
      it 'ラベルを含むタスクで絞り込まれる' do
        select 'ラベル1', from: 'ラベル'
        click_button '検索'
        expect(page).to have_selector 'td', text: 'ラベル2'
      end
    end
    context 'ステータスとラベルで検索した場合' do
      it 'ステータスとラベルに完全一致するタスクが絞り込まれる' do
        select '未着手', from: 'ステータス'
        select 'ラベル3', from: 'ラベル'
        click_button '検索'
        expect(page).to have_selector 'td', text: '未着手'
        expect(page).to have_selector 'td', text: 'ラベル3'
      end
    end
    context 'タイトルのあいまい検索とラベルで検索した場合' do
      it '検索キーワードのタイトルを含む、ラベルに一致するタスクが絞り込まれる' do
        fill_in 'タスク名', with: 'first'
        select 'ラベル1', from: 'ラベル'
        click_button '検索'
        expect(page).to have_selector 'td', text: 'first_title'
        expect(page).to have_selector 'td', text: 'ラベル1'
      end
    end
    context 'タイトルのあいまい検索、ステータス、ラベルで検索した場合' do
      it '検索キーワードのタイトルを含む、ステータス、ラベルに完全一致するタスクが絞り込まれる' do
        fill_in 'タスク名', with: 'second'
        select '未着手', from: 'ステータス'
        select 'ラベル3', from: 'ラベル'
        click_button '検索'
        expect(page).to have_selector 'td', text: 'second_title'
        expect(page).to have_selector 'td', text: '未着手'
        expect(page).to have_selector 'td', text: 'ラベル3'
      end
    end
    describe 'ラベル編集機能' do
      context 'ラベルを編集した場合' do
        it '編集後のラベルをつけたタスクが表示される' do
          visit edit_task_path(task.id)
          check "ラベル3"
          click_button '更新する'
          fill_in 'タスク名', with: 'first_title'
          click_button '検索'
          expect(page).to have_selector 'td', text: 'ラベル3'
        end
      end
    end
  end
end