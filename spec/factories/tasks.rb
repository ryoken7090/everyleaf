FactoryBot.define do
  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル1' }
    content { 'Factoryで作ったデフォルトのコンテント1' }
    expired_at { '2020-07-02' }
  end
  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル1' }
    content { 'Factoryで作ったデフォルトのコンテント1' }
    expired_at { '2020-07-02' }
  end
end
