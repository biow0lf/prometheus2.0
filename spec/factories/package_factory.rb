# frozen_string_literal: true

FactoryBot.define do
   factory :package do
      name { Faker::App.name.downcase }
      version { Faker::App.semantic_version }
      release { 'alt' + Faker::App.semantic_version }
      buildtime { Time.zone.now }
      md5 { Digest::MD5.hexdigest("#{@instance.name}-#{@instance.version}-#{@instance.release}-#{@instance.buildtime}") }
      groupname 'Graphical desktop/Other'
      arch { %w(i586 x86_64 noarch aarch64 mipsel armh)[rand(6)] }
      association :builder, factory: :maintainer
      type 'Package::Built'

      group

      trait :src do
         arch 'src'
         type 'Package::Src'
      end
   end
end
