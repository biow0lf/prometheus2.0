FactoryGirl.define do
  factory :group do
    branch
    name { Faker::Commerce.department(1) }
    parent_id nil
  end
end
