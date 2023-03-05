require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションに引っかかる' do
        task = Task.new(title: '', content: '失敗テスト', expired_at: "2022-01-01", status: "未着手")
        expect(task).not_to be_valid
      end
    end 

    context 'タスクの詳細が空の場合' do
      it 'バリデーションに引っかかる' do
        task = Task.new(title: '失敗テスト', content: '', expired_at: "2022-01-01", status: "未着手")
        expect(task).not_to be_valid
      end
    end
    
    context 'タスクの終了期限が空の場合' do
      it 'バリデーションに引っかかる' do
        task = Task.new(title: '失敗テスト', content: '失敗テスト', expired_at: "", status: "未着手")
        expect(task).not_to be_valid
      end
    end
    
    context 'タスクのステータスが空の場合' do
      it 'バリデーションに引っかかる' do
        task = Task.new(title: '失敗テスト', content: '失敗テスト', expired_at: "2022-01-01", status: "")
        expect(task).not_to be_valid
      end
    end
    
    context 'タスクのタイトル、詳細、終了期限とステータスに内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: "成功テスト", content: "成功テスト", expired_at: "2022-01-01", status: "未着手")
        expect(task).to be_valid
      end
    end

    context 'タスクのタイトルが101字以上の場合' do
      it 'バリデーションに引っかかる' do
        task = Task.new(title: '*'*101, content: '失敗テスト', expired_at: "2022-01-01", status: "未着手")
        expect(task).not_to be_valid
      end
    end

    context 'タスクのタイトルが100字以内の場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '*'*100, content: '成功テスト', expired_at: "2022-01-01", status: "未着手")
        expect(task).to be_valid
      end
    end

    context 'タスクの詳細が301字以上の場合' do
      it 'バリデーションに引っかかる' do
        task = Task.new(title: '失敗テスト', content: '*'*301, expired_at: "2022-01-01", status: "未着手")
        expect(task).not_to be_valid
      end
    end

    context 'タスクの詳細が300字以内の場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト', content: '*'*300, expired_at: "2022-01-01", status: "未着手")
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    let!(:task1) { FactoryBot.create(:task) }
    let!(:task2) { FactoryBot.create(:second_task) }
    let!(:task3) { FactoryBot.create(:third_task) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.title_search("first")).to include(task1)
        expect(Task.title_search("first")).not_to include(task2)
        expect(Task.title_search("first").count).to eq 1
      end
    end

    context 'scopeメソッドでステータス検索をした場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        expect(Task.status_search("着手中")).to include(task1)
        expect(Task.status_search("着手中")).to include(task3)
        expect(Task.status_search("着手中")).not_to include(task2)
        expect(Task.status_search("着手中").count).to eq 2
      end
    end

    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる' do
         expect(Task.title_and_status_search("first", "着手中")).to include(task1)
         expect(Task.title_and_status_search("first", "着手中")).not_to include(task3)
         expect(Task.title_and_status_search("first", "着手中").count).to eq 1
      end
    end
  end
end