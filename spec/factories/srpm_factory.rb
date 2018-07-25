# frozen_string_literal: true

FactoryBot.define do
  factory :srpm do
    name { Faker::App.name.downcase }
    version { Faker::App.semantic_version }
    release { 'alt' + Faker::App.semantic_version }
    buildtime { Time.zone.now }
    md5 { Digest::MD5.hexdigest("#{@instance.name}-#{@instance.version}-#{@instance.release}-#{@instance.buildtime}") }
    groupname 'Graphical desktop/Other'

    transient do
      filename nil
      branchname { Faker::App.name }
      branch nil
    end

    after(:build) do |o, e|
      filename = e.filename || "#{o.name}-#{o.version}-#{o.release}.src.rpm"
      o.named_srpms << build(:named_srpm, name: filename,
                                          branch: e.branch,
                                          branchname: e.branchname)
      o.group ||= create(:group, branch: o.named_srpms.first.branch)
    end
  end
end
