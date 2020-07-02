5.times do |n|
  User.create!(
    email: "test#{n + 1}@example.com",
    name: "テスト#{n + 1}",
    password: "password",
    password_confirmation: "password"
  )
end
User.all.each do |user|
  20.times do |n|
    user.tasks.create!(
      title: 'タイトル',
      content: '内容はこれ！',
      status: "着手中",
      priority: "中",
      user_id: user.id
    )
  end
end
User.create!(
  email: "admin1@example.com",
  name: "管理者1",
  password: "password",
  password_confirmation: "password",
  admin: true
)
