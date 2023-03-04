require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
    let!(:task1) { FactoryBot.create(:task) }
    let!(:task2) { FactoryBot.create(:second_task) }

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タイトル', with: 'new_task'
        fill_in '内容', with: 'new_content'
        fill_in '終了期限', with: Date.new(2023, 5, 4)
        click_button '登録する'
        expect(page).to have_content 'new_task'
        expect(page).to have_content 'new_content'
        expect(page).to have_content '2023-05-04'
      end
    end
  end
  
  describe '一覧表示機能' do
    before do
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'task1-1'
        expect(page).to have_content 'task1-2'
        expect(page).to have_content 'task2-1'
        expect(page).to have_content 'task2-2'
        expect(page).to have_content '2023-04-25'
        expect(page).to have_content '2023-01-01'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        new_task = all('.task_row tr')[0]
        expect(new_task).to have_content 'task2-1'
        expect(new_task).to have_content 'task2-2'
        expect(new_task).to have_content '2023-01-01'
      end
    end

    context '終了期限をクリックするとタスクが降順に並んでいる場合' do
      it '終了期限が一番遠いタスクが一番上に表示される' do
        click_on '終了期限'
        sleep(1)
        most_recent_task = all('.task_row tr')[0]
        expect(most_recent_task).to have_content '2023-04-25'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit task_path(task1)
        expect(page).to have_content 'task1-1'
        expect(page).to have_content 'task1-2'
        expect(page).to have_content '2023-04-25'
      end
      it '該当タスクの内容が表示される_2' do
        visit task_path(task2)
        expect(page).to have_content 'task2-1'
        expect(page).to have_content 'task2-2'
        expect(page).to have_content '2023-01-01'
      end
    end
  end
end