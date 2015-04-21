FactoryGirl.define do
  factory :package do
    srpm
    arch { %w(i586 x86_64 noarch).sample }
    groupname { Faker::Commerce.department(1) }
    summary { Faker::Lorem.sentence }
    license { Faker::Lorem.word.capitalize }
    url { Faker::Internet.url }
    description { Faker::Lorem.paragraph }
    buildtime { Time.now }
    md5 { SecureRandom.hex }
    size { Faker::Number.number(9) }

    after(:build) do |package|
      package.name = package.srpm.name
      package.version = package.srpm.version
      package.release = package.srpm.release
      package.epoch = package.srpm.epoch
      package.filename = "#{ package.name }-#{ package.version }-#{ package.release }.#{ package.arch }.rpm"
      package.sourcepackage = package.srpm.filename
      package.group = create(:group, name: package.groupname, branch: package.srpm.branch)
    end
  end
end
