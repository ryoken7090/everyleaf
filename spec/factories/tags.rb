FactoryBot.define do
  factory :first_tag, class: Tag do
    title { "テストタグ(1)" }
  end
  factory :second_tag, class: Tag do
    title { "テストタグ(2)" }
  end
end
