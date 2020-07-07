require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :model do
  before do
    @user = User.create(name: 'テストユーザー', email: 'sample@example.com', password: '00000000')
  end
  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(title: '', content: '失敗テスト', user_id: @user.id)
    expect(task).not_to be_valid
  end
  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', content: '', user_id: @user.id)
    expect(task).not_to be_valid
  end
  it 'titleとcontentに内容が記載されていればバリデーションが通る' do
    task = Task.new(title: 'タイトル内容あり', content: 'コンテント内容あり', user_id: @user.id)
    expect(task).to be_valid
  end
  context 'scopeメソッドで検索をした場合' do
    before do
      Task.create(title: "task01", content: "sample_task", status: "着手中", user_id: @user.id)
      Task.create(title: "sample", content: "sample_sample", status: "完了", user_id: @user.id)
      Task.create(title: "second_task", content: "sample_sample", status: "完了", user_id: @user.id)
    end
    it "scopeメソッドでタイトル検索ができる" do
      expect(Task.title_search('task').count).to eq 2
    end
    it "scopeメソッドでステータス検索ができる" do
      expect(Task.status_search('着手中').count).to eq 1
    end
    it "scopeメソッドでタイトルとステータスの両方が検索できる" do
      expect(Task.title_search('task').status_search('完了').count).to eq 1
    end
  end
end
