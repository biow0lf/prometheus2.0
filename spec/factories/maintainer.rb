FactoryGirl.define do
  factory :maintainer do
    name { Faker::Name.name }
    login { Faker::Internet.user_name }
    email { "#{ login }@altlinux.org" }
    time_zone 'UTC'
    jabber { "#{ login }@altlinux.org" }
    info { Faker::Lorem.paragraph }
    website { Faker::Internet.url }
    location { Faker::Address.country }
  end
end
