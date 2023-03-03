require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
    let!(:task1) {FactoryBot.create(:task)}
    let!(:task2) {FactoryBot.create(:second_task)}

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タイトル', with: 'new_task'
        fill_in '内容', with: 'new_content'
        click_button '登録する'
        expect(page).to have_content 'new_task'
        expect(page).to have_content 'new_content'
      end
    end
  end
  
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'task1-1'
        expect(page).to have_content 'task1-2'
        expect(page).to have_content 'task2-1'
        expect(page).to have_content 'task2-2'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        visit task_path(task1)
        expect(page).to have_content 'task1-1'
        expect(page).to have_content 'task1-2'
       end
       it '該当タスクの内容が表示される_2' do
        visit task_path(task2)
        expect(page).to have_content 'task2-1'
        expect(page).to have_content 'task2-2'
       end
     end
  end
end