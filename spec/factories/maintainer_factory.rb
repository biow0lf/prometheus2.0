FactoryBot.define do
  factory :maintainer do
    name { Faker::Name.name }
    sequence :login do |n|
      "#{ Faker::Internet.user_name }#{ n }"
    end
    email { "#{ login }@altlinux.org" }
    time_zone 'UTC'
    jabber { "#{ login }@altlinux.org" }
    info { Faker::Lorem.paragraph }
    website { Faker::Internet.url }
    location { Faker::Address.country }
  end
end
