# frozen_string_literal: true

FactoryBot.define do
  factory :architecture do
    platform

    name { Faker::Lorem.word }
  end
end
