FactoryBot.define do
  sequence :name do |n|
    "Branch #{ n }"
  end

  factory :branch do
    name
    vendor 'Vendor'
    order_id 0
    path '/Anything'
  end
end
