require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do
  describe 'ユーザ登録のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'ユーザ新規登録のテスト' do
        visit new_user_path
        fill_in 'Name', with: 'sample'
        fill_in 'Email', with: 'sample@example.com'
        fill_in 'Password', with: '00000000'
        fill_in 'Password confirmation', with: '00000000'
        click_on '登録する'
        expect(current_path).to eq user_path(id: 1)
      end
      it 'ログインしていない時はログイン画面に飛ぶテスト' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end
end
