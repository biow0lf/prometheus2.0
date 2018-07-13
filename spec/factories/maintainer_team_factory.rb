# frozen_string_literal: true

FactoryBot.define do
  factory :maintainer_team do
    name 'Ruby Maintainers Team'
    email 'ruby@packages.altlinux.org'
    login 'ruby'
  end
end
