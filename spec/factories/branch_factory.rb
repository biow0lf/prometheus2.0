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

    trait :with_paths do
      after(:create) do |b, e|
        source_path = create(:src_branch_path, branch: b, path: "/path/to/src/for/#{b.name}")

        if e.arches
          e.arches.each { |a| create(:branch_path, arch: a, path: a, branch: b, source_path: source_path)}
        end
      end
    end
  end
end
