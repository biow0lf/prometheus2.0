# frozen_string_literal: true

FactoryBot.define do
  sequence :name do |n|
    "Branch #{ n }"
  end

  factory :branch do
    name
    vendor 'Vendor'
    sequence(:order_id)
    path '/Anything'
  end
end
