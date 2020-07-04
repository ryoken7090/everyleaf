require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do
  describe 'ユーザ登録のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'ユーザ新規登録のテスト' do
        visit new_user_path
        fill_in '名前', with: 'sample'
        fill_in 'メールアドレス', with: 'sample@example.com'
        fill_in 'パスワード', with: '00000000'
        fill_in '確認用パスワード', with: '00000000'
        click_on '登録する'
        expect(current_path).to eq user_path(id: 1)
      end
      it 'ログインしていない時はログイン画面に飛ぶテスト' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe 'セッション機能のテスト' do
    before do
      FactoryBot.create(:user, name:"sample1", email:"sample1@example.com", id:1)
      FactoryBot.create(:user, name:"sample2", email:"sample2@example.com", id: 2)
    end
    context 'ユーザのデータがありログインしていない場合' do
      it 'ユーザーログイン画面のテスト' do
        visit new_session_path
        fill_in 'Email', with: 'sample1@example.com'
        fill_in 'Password', with: '00000000'
        click_on 'ログイン'
        expect(page).to have_content 'sample1のページ'
      end
    end
    context 'ログイン状態の時' do
      it '自分のユーザー詳細画面に飛べること' do

      end
      it '他人の詳細画面に飛ぶとタスク一覧ページに遷移すること' do

      end
      it 'ログアウトができること' do

      end
    end
  end
  describe '管理者画面のテスト' do
    context '一般ユーザーでログインしている時' do
      it '管理者画面にアクセスできない' do

      end
    end
    context '管理者としてログインしている時' do
      it '管理画面にアクセスできる' do

      end
      it 'ユーザーを新規登録できる' do

      end
      it 'ユーザーの詳細画面に遷移できる' do

      end
      it 'ユーザーを編集できる' do

      end
      it 'ユーザーの削除ができる' do

      end
    end
  end
end
