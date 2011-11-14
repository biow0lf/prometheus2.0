# encoding: utf-8

require 'spec_helper'

describe Gear do
  it { should belong_to :maintainer }
  it { should belong_to :srpm }

  it { should validate_presence_of :repo }
  it { should validate_presence_of :lastchange }

  it { should have_db_index :maintainer_id }
  it { should have_db_index :srpm_id }
end
