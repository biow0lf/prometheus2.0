FactoryGirl.define do
  factory :maintainer do
    name { "#{ Faker::Name.first_name } #{ Faker::Name.last_name }" }
    sequence(:login) { |n| "#{ Faker::Internet.user_name }#{ n }" }
    email { "#{ login }@altlinux.org" }
    time_zone { Faker::Address.time_zone }
    jabber { "#{ login }@altlinux.org" }
    info { Faker::Lorem.paragraph }
    website { Faker::Internet.url }
    location { Faker::Address.country }
  end
end
