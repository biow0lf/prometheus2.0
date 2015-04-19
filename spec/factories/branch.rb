FactoryGirl.define do
  factory :branch do
    name { "#{ Faker::Lorem.word.capitalize }" }
    vendor { Faker::Company.name }
    sequence(:order_id, 0) { |n| "#{ n }" }
  end
end
