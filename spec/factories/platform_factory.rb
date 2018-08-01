# frozen_string_literal: true

FactoryBot.define do
  factory :platform do
    name { Faker::Lorem.word }
    version { Faker::Lorem.word }
  end
end
