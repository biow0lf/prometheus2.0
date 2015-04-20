FactoryGirl.define do
  factory :srpm do
    branch { group.branch }
    name { Faker::Lorem.word }
    version { Faker::App.version }
    sequence(:release) { |n| "alt#{ n }" }
    epoch { Time.now.strftime('%Y%m%d').to_i }
    group
    groupname { group.name }
    filename { "#{ name }-#{ version }-#{ release }.src.rpm" }
    summary { Faker::Lorem.sentence }
    license { Faker::Lorem.word.capitalize }
    url { Faker::Internet.url }
    description { Faker::Lorem.paragraph }
    buildtime { Time.now }
    vendor { Faker::Company.name }
    distribution { Faker::Lorem.word }
    repocop 'skip'
    # TODO:
    # t.string   "changelogname"
    # changelogname ''
    changelogtext { "- new version #{ version }" }
    changelogtime { Time.now }
    # TODO:
    # t.integer  "builder_id"
    # builder
    md5 { SecureRandom.hex }
    size { Faker::Number.number(9) }
  end
end
