FactoryBot.define do
  factory :store do
    sequence(:name, 1) do |n|
      "テスト店舗#{n}"
    end
  end
end
