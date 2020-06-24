require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        FactoryBot.create(:task, title: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の順に並んでいる' do
        FactoryBot.create(:task, title: 'task')
        FactoryBot.create(:task, title: 'new_task')
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'new_task'
        expect(task_list[1]).to have_content 'task'
      end
    end
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in 'タイトル', with: 'テストのタイトル'
        fill_in '内容', with: 'コンテンツ'
        click_button 'Submit'
        expect(page).to have_content 'テストのタイトル'
      end
    end
  end
  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移する' do
        FactoryBot.create(:task, content: 'target task')
        5.times {FactoryBot.create(:task)}
        visit tasks_path
        all('tbody tr')[5].click_link 'Show'
        expect(page).to have_content 'target task'
      end
    end
  end
end
