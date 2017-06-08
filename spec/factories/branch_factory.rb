FactoryGirl.define do
  sequence :name do |n|
    "Branch name #{ n }"
  end

  sequence :vendor do |n|
    "Vendor name #{ n }"
  end

  factory :branch do
    name
    vendor
    order_id 0
    path '/Anything'
  end
end
