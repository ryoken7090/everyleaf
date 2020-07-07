FactoryBot.define do
  # factory :user, class: User do
  #   id { 1 }
  #   name { 'sample' }
  #   email { 'sample@example.com' }
  #   password { '00000000' }
  #   admin { false }
  # end
  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル1' }
    content { 'Factoryで作ったデフォルトのコンテント1' }
    expired_at { '2020-07-02' }
    user
  end
  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル1' }
    content { 'Factoryで作ったデフォルトのコンテント1' }
    expired_at { '2020-07-02' }
    user
  end
end
