FactoryBot.define do
  factory :token, class: SolidusJwt::Token do
    association :user

    trait :expired do
      created_at { 1.year.ago }
    end

    trait :inactive do
      active { false }
    end
  end
end
