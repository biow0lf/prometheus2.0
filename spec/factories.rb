FactoryGirl.define do
  factory :group do
    name 'Graphical desktop'
    parent_id nil
  end

  factory :maintainer_team do
    name 'Ruby Maintainers Team'
    email 'ruby@packages.altlinux.org'
    login 'ruby'
  end
end
