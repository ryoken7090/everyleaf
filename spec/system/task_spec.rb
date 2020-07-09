require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    FactoryBot.create(:task, user: @user)
    FactoryBot.create(:second_task, user: @user)
    visit new_session_path
    fill_in 'Email', with: 'sample@example.com'
    fill_in 'Password', with: '00000000'
    click_on 'ログイン'
  end
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        visit tasks_path
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル1'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが更新日時の古い順に並んでいる' do
        FactoryBot.create(:task, title: 'new_task', user: @user)
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[2]).to have_content 'new_task'
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのコンテント1'
      end
    end
    context '終了期限でソートするリンクを押した場合' do
      it '終了時刻の遅いタスクが後ろに並んでいる' do
        FactoryBot.create(:task, expired_at: '2020-08-01', user: @user)
        visit tasks_path(sort_expired: "true")
        task_list = all('.task_row')
        expect(task_list[2]).to have_content '2020年08月01日'
      end
    end
    context '検索をした場合' do
      before do
        FactoryBot.create(:task, title: "task", status: "完了", user: @user)
        FactoryBot.create(:second_task, title: "sample", status: "完了", user: @user)
        FactoryBot.create(:second_task, title: "着手中のタスクタイトル", status: "着手中", user: @user)
      end
      it "タイトルで検索できる" do
        visit tasks_path
        fill_in 'タイトル検索', with: 'sample'
        click_button '検索'
        expect(page).to have_content 'sample'
      end
      it "ステータスで検索できる" do
        visit tasks_path
        select '完了', from: 'ステータスで検索'
        click_button '検索'
        expect(page).to have_content 'sample'
      end
      it "タイトルとステータスで検索できる" do
        visit tasks_path
        fill_in 'タイトル検索', with: 'タイトル'
        select '着手中', from: 'ステータスで検索'
        click_button '検索'
        expect(page).to have_content '着手中のタスクタイトル'
        expect(page).not_to have_content 'Factoryで作ったデフォルトのタイトル1'
      end
    end
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、送信ボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in 'タイトル', with: '入力したタイトル'
        fill_in '内容', with: '入力したコンテンツ'
        select '2020', from: 'task_expired_at_1i'
        select '9月', from: 'task_expired_at_2i'
        select '1', from: 'task_expired_at_3i'
        click_button '送信'
        expect(page).to have_content '入力したタイトル'
        expect(page).to have_content '2020年09月01日'
      end
    end
  end
  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移する' do
        FactoryBot.create(:task, content: 'target task', user: @user)
        5.times {FactoryBot.create(:task, user: @user)}
        visit tasks_path
        all('tbody tr')[2].click_link '詳細'
        expect(page).to have_content 'target task'
      end
    end
  end
end
