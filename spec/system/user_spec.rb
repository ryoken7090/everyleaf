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
      @user_one = FactoryBot.create(:user, name:"sample1", email:"sample1@example.com", id:1)
      @user_two = FactoryBot.create(:user, name:"sample2", email:"sample2@example.com", id: 2)
    end
    context 'ユーザのデータがありログインしていない場合' do
      it 'ユーザーログイン画面のテスト' do
        visit new_session_path
        fill_in 'Email', with: 'sample1@example.com'
        fill_in 'Password', with: '00000000'
        click_on 'ログイン'
        expect(current_path).to eq user_path(id: 1)
      end
    end
    context 'ログイン状態の時' do
      before do
        visit new_session_path
        fill_in 'Email', with: 'sample1@example.com'
        fill_in 'Password', with: '00000000'
        click_on 'ログイン'
      end
      it '自分のユーザー詳細画面に飛べること' do
        visit user_path(@user_one)
        expect(page).to have_content 'sample1のページ'
      end
      it '他人の詳細画面に飛ぶとタスク一覧ページに遷移すること' do
        visit user_path(@user_two)
        expect(current_path).to eq tasks_path
        expect(page).to have_content '他ユーザーのページには遷移できません'
      end
      it 'ログアウトができること' do
        click_link 'ログアウト'
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe '管理者画面のテスト' do
    before do
      @general_user = FactoryBot.create(:user)
      @admin_user = FactoryBot.create(:admin_user)
    end
    context '一般ユーザーでログインしている時' do
      before do
        visit new_session_path
        fill_in 'Email', with: 'sample@example.com'
        fill_in 'Password', with: '00000000'
        click_on 'ログイン'
      end
      it '管理者画面にアクセスできない' do
        visit admin_users_path
        expect(current_path).to eq tasks_path
        expect(page).to have_content '一般ユーザーは管理者ページに入れません'
      end
    end
    context '管理者としてログインしている時' do
      before do
        visit new_session_path
        fill_in 'Email', with: 'admin@example.com'
        fill_in 'Password', with: '00000000'
        click_on 'ログイン'
      end
      it '管理画面にアクセスできる' do
        visit admin_users_path
        expect(current_path).to eq admin_users_path
        expect(page).to have_content '管理者画面'
      end
      it 'ユーザーを新規登録できる' do

      end
      it 'ユーザーの詳細画面に遷移できる' do
        visit admin_user_path(@general_user)
        expect(current_path).to eq admin_user_path(@general_user)
        expect(page).to have_content 'sampleのページ'
      end
      it 'ユーザーを編集できる' do
        visit admin_user_path(@general_user)
        click_link 'ユーザー編集'
        fill_in '名前', with: 'sample_edit'
        fill_in 'メールアドレス', with: 'sample_edit@example.com'
        fill_in 'パスワード', with: '00000000'
        fill_in '確認用パスワード', with: '00000000'
        click_on 'edit'
        expect(current_path).to eq admin_users_path
        expect(page).to have_content '更新しました'
        click_link 'sample_edit'
        expect(page).to have_content 'sample_edit@example.com'
      end
      it 'ユーザーの削除ができる' do
      
      end
    end
  end
end
