# encoding: utf-8

require 'spec_helper'

describe Acl do
  it { should have_db_index :branch_id }
  it { should have_db_index :maintainer_id }
  it { should have_db_index :srpm_id }

  pending "acl import and update"
end
