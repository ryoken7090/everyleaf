require 'rails_helper'
RSpec.describe 'タグ付け機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    FactoryBot.create(:first_tag)
    FactoryBot.create(:second_tag)
    visit new_session_path
    fill_in 'Email', with: 'sample@example.com'
    fill_in 'Password', with: '00000000'
    click_on 'ログイン'
  end
  describe 'タグ登録画面' do
    context 'タグ名を入力して送信ボタンを押した場合' do
      it '新規タグが作成される' do
        visit new_tag_path
        fill_in 'タグ名', with: '新規作成したタグ'
        click_button '送信'
        expect(page).to have_content '新規作成したタグ'
      end
    end
    context '必要項目を入力し、タグを選択し送信ボタンを押した場合' do
      it 'タグ付けされたタスクが保存される' do
        visit new_task_path
        fill_in 'タイトル', with: '入力したタイトル'
        fill_in '内容', with: '入力したコンテンツ'
        select '2020', from: 'task_expired_at_1i'
        select '9月', from: 'task_expired_at_2i'
        select '1', from: 'task_expired_at_3i'
        select '未着手', from: 'task_status'
        select '低', from: 'task_priority'
        check 'task_tagging_tag_ids_4'
        click_button '送信'
        expect(page).to have_content '入力したタイトル'
        expect(page).to have_content '2020年09月01日'
        expect(page).to have_content 'テストタグ(1)'
      end
    end
    context '1件新規タスクにタグ付をし既存のタスク１件にも編集画面からタグ付をした場合' do
      before do
        5.times {FactoryBot.create(:task, user: @user)}
      end
      it 'index画面でタグで検索して2件タスクを洗い出せる' do
        click_link 'タスク一覧'
        click_link '新しいタスク'
        fill_in 'タイトル', with: '新規タグ付タスク'
        fill_in '内容', with: '入力したコンテンツ'
        check 'task_tagging_tag_ids_6'
        check 'task_tagging_tag_ids_7'
        click_button '送信'
        click_link '一覧'
        all('tbody tr')[0].click_link '編集'
        check 'task_tagging_tag_ids_7'
        click_button '送信'
        click_link '一覧'
        select 'テストタグ(2)', from: 'タグで検索'
        click_button 'タグ検索'
        all('tbody tr').count eq 2
      end
    end
  end
end
