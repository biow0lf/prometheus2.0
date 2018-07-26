FactoryBot.define do
  factory :named_srpm do
    transient do
      branchname { Faker::App.name }
    end

    after(:build) do |o, e|
      o.branch ||= create(:branch, name: e.branchname)
    end
  end
end
