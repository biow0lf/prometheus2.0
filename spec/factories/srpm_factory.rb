# frozen_string_literal: true

FactoryBot.define do
  factory :srpm do
    branch

    name 'openbox'
    version '3.4.11.1'
    release 'alt1.1.1'
    groupname 'Graphical desktop/Other'
    filename 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    md5 'f87ff0eaa4e16b202539738483cd54d1'
  end
end
