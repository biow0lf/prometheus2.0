FactoryGirl.define do
  factory :srpm do
    branch
    name { Faker::Lorem.word }
    version { Faker::App.version }
    sequence(:release) { |n| "alt#{ n }" }
    epoch { Time.now.strftime('%Y%m%d').to_i }
    groupname { Faker::Commerce.department(1) }
    filename { "#{ name }-#{ version }-#{ release }.src.rpm" }
    summary { Faker::Lorem.sentence }
    license { Faker::Lorem.word.capitalize }
    url { Faker::Internet.url }
    description { Faker::Lorem.paragraph }
    buildtime { Time.now }
    vendor { Faker::Company.name }
    distribution { Faker::Lorem.word }
    repocop { %w(skip ok info experimental warn fail).sample }
    changelogtext { "- new version #{ version }" }
    changelogtime { Time.now }
    md5 { SecureRandom.hex }
    size { Faker::Number.number(9) }

    after(:build) do |srpm|
      srpm.group = create(:group, name: srpm.groupname, branch: srpm.branch)
      srpm.builder_id = create(:maintainer).id
    end

    after(:create) do |srpm|
      srpm.changelogname = "#{ srpm.builder.name } <#{ srpm.builder.email }> #{ srpm.version }-#{ srpm.release }"
      srpm.save!
    end
  end
end
