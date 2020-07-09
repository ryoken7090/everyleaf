require 'rails_helper'
RSpec.describe 'タグ付け機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    FactoryBot.create(:tag)
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

        check 'テストタグ'
        click_button '送信'
        expect(page).to have_content '入力したタイトル'
        expect(page).to have_content '2020年09月01日'
        expect(page).to have_content 'テストタグ'
      end
    end
  end
end
