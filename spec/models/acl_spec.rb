# encoding: utf-8

require 'spec_helper'

describe Acl do
  it { should belong_to :branch }
  it { should belong_to :maintainer }
  it { should belong_to :srpm }

  it { should validate_presence_of :branch }
  it { should validate_presence_of :maintainer }
  it { should validate_presence_of :srpm }

  it { should have_db_index :branch_id }
  it { should have_db_index :maintainer_id }
  it { should have_db_index :srpm_id }
end
