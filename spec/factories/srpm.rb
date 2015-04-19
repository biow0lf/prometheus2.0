FactoryGirl.define do
  factory :srpm do
    branch { group.branch }
    name { "#{ Faker::Lorem.word }" }
    version { "#{ Faker::App.version }" }
    sequence(:release) { |n| "alt#{ n }" }
    epoch nil
    group
    groupname { group.name }
    filename { "#{ name }-#{ version }-#{ release }.src.rpm" }
    md5 'f87ff0eaa4e16b202539738483cd54d1'
  end
end
