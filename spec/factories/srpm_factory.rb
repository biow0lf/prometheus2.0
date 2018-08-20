# frozen_string_literal: true

FactoryBot.define do
  factory :srpm do
    name { Faker::App.name.downcase }
    version { Faker::App.semantic_version }
    release { 'alt' + Faker::App.semantic_version }
    buildtime { Time.zone.now }
    md5 { Digest::MD5.hexdigest("#{@instance.name}-#{@instance.version}-#{@instance.release}-#{@instance.buildtime}") }
    groupname 'Graphical desktop/Other'
    association :builder, factory: :maintainer

    transient do
      filename nil
      branch nil
    end

    after(:build) do |o, e|
      filename = e.filename || "#{o.name}-#{o.version}-#{o.release}.src.rpm"

      o.group ||= create(:group)
    end
  end
end
