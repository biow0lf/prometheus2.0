# frozen_string_literal: true

FactoryBot.define do
  sequence :name do |n|
    "Branch #{ n }"
  end

  factory :branch do
    name
    vendor { Faker::App.name }
    sequence(:order_id)
    path '/Anything'

    transient do
      arches nil
    end

    after(:build) do |b, e|
      if e.arches
        b.branch_paths = e.arches.map { |a| build(:branch_path, arch: a, path: a) }
      end
    end
  end
end
