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
end