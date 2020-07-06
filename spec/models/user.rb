require 'rails_helper'
RSpec.describe 'ユーザー作成機能', type: :model do
  it '名前とメールアドレスとパスワードが記載されていればバリデーションが通る' do
    user = User.new(name: '成功テスト', email: 'sample@example.com', password: '00000000')
    expect(user).to be_valid
  end
  it '名前が空ならバリデーションが通らない' do
    user = User.new(name: '', email: 'sample@example.com', password: '00000000')
    expect(user).not_to be_valid
  end
  it 'メールアドレスが空ならバリデーションが通らない' do
    user = User.new(name: '失敗テスト', email: '', password: '00000000')
    expect(user).not_to be_valid
  end
end
