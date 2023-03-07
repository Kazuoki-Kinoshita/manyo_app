require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
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
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タスク名', with: 'new_task'
        fill_in '内容', with: 'new_content'
        fill_in '終了期限', with: Date.new(2023, 5, 4)
        select '完了', from: 'ステータス'
        select '中', from: '優先度'
        click_button '登録する'
        expect(page).to have_content 'new_task'
        expect(page).to have_content 'new_content'
        expect(page).to have_content '2023-05-04'
        expect(page).to have_content '完了'
        expect(page).to have_content '中'
      end
    end
  end
  
  describe '一覧表示機能' do
    before do
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'first_title'
        expect(page).to have_content 'first_content'
        expect(page).to have_content 'second_title'
        expect(page).to have_content 'second_content'
        expect(page).to have_content '2023-04-25'
        expect(page).to have_content '2023-01-01'
        expect(page).to have_content '着手中'
        expect(page).to have_content '未着手'
        expect(page).to have_content '高'
        expect(page).to have_content '低'

      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        new_task = all('.task_row tr')[0]
        expect(new_task).to have_content 'second_title'
        expect(new_task).to have_content 'second_content'
        expect(new_task).to have_content '2023-01-01'
        expect(new_task).to have_content '未着手'
        expect(new_task).to have_content '低'
      end
    end
    context '終了期限をクリックするとタスクが降順に並んでいる場合' do
      it '終了期限が一番あとのタスクが一番上に表示される' do
        click_on '終了期限'
        sleep(1)
        latest_task = all('.task_row tr')[0]
        expect(latest_task).to have_content '2023-04-25'
        expect(latest_task).to have_content '着手中'
        expect(latest_task).to have_content '高'
      end
    end
    context '優先度をクリックするとタスクが降順に並んでいる場合' do
      it '優先度が一番高いタスク（高）が一番上に表示される' do
        click_on '優先度'
        sleep(1)
        highest_priority = all('.task_row tr')[0]
        expect(highest_priority).to have_content '2023-04-25'
        expect(highest_priority).to have_content '着手中'
        expect(highest_priority).to have_content '高'
      end
    end
  end

  describe '検索機能' do
    let!(:task3) { FactoryBot.create(:task3, user: user) }
    before do
      visit tasks_path
    end
    context 'タイトルをあいまいで検索した場合' do
      it '検索キーワードを含むタスクで絞り込まれる' do
        fill_in 'タスク名', with: 'first'
        click_button '検索'
        expect(page).to have_content 'first_title'
      end
    end
    context 'ステータスを検索した場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        select '未着手', from: 'ステータス'
        click_button '検索'
        expect(page).to have_selector 'td', text: '未着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる' do
        fill_in 'タスク名', with: 'first'
        select '着手中', from: 'ステータス'
        click_button '検索'
        expect(page).to have_content 'first_title'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit task_path(task)
        expect(page).to have_content 'first_title'
        expect(page).to have_content 'first_content'
        expect(page).to have_content '2023-04-25'
        expect(page).to have_content '着手中'
      end
      it '該当タスクの内容が表示される_2' do
        visit task_path(task2)
        expect(page).to have_content 'second_title'
        expect(page).to have_content 'second_content'
        expect(page).to have_content '2023-01-01'
        expect(page).to have_content '未着手'
      end
    end
  end
end