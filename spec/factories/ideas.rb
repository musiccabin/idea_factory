FactoryBot.define do
  factory :idea do
    title { Faker::Quotes }
    description { Faker::Quotes::Shakespeare.romeo_and_juliet_quote }
    association(:user, factory: :user)
  end
end
