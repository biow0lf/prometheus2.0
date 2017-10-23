FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    factory :user_confirmed do
      confirmed_at { Time.zone.now }
    end
  end
end
