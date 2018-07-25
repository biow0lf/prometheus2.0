# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    trait :confirmed do
      confirmed_at { Time.zone.now }
    end
  end
end
