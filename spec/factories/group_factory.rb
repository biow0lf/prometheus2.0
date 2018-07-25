# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    name { Faker::App.name }

    branch
  end
end
