# frozen_string_literal: true

FactoryBot.define do
  factory :srpm do
    branch

    name { Faker::App.name.downcase }
    version { Faker::App.semantic_version }
    release { 'alt' + Faker::App.semantic_version }
    groupname 'Graphical desktop/Other'
    filename { "#{@instance.name}-#{@instance.version}-#{@instance.release}.src.rpm" }
    md5 { Digest::MD5.hexdigest(@instance.filename) }

    buildtime { Time.zone.now }

    after(:build) do |o|
      o.group = create(:group, branch: o.branch)
    end
  end
end
