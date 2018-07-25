# frozen_string_literal: true

FactoryBot.define do
  factory :package do
    name { Faker::App.name.downcase }
    version { Faker::App.semantic_version }
    release { 'alt' + Faker::App.semantic_version }
    buildtime { Time.zone.now }
    md5 { Digest::MD5.hexdigest("#{@instance.name}-#{@instance.version}-#{@instance.release}-#{@instance.buildtime}") }
    groupname 'Graphical desktop/Other'
    filename { "#{@instance.name}-#{@instance.version}-#{@instance.release}" }

    srpm
    group
  end
end
