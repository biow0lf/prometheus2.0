# encoding: utf-8

FactoryGirl.define do
  factory :branch do
    name 'Sisyphus'
    vendor 'ALT Linux'
    order_id 0
  end

  factory :group do
    name 'Graphical desktop'
    parent_id nil
  end

  factory :srpm do
    name 'openbox'
    version '3.4.11.1'
    release 'alt1.1.1'
    filename 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    md5 'f87ff0eaa4e16b202539738483cd54d1'
  end

  factory :maintainer do
    name 'Igor Zubkov'
    email 'icesik@altlinux.org'
    login 'icesik'
  end

  factory :maintainer_team do
    name 'Ruby Maintainers Team'
    email 'ruby@packages.altlinux.org'
    login 'ruby'
  end
end
