# encoding: utf-8

require 'spec_helper'

describe Team do
  it { should belong_to :branch }
  it { should belong_to :maintainer }

  it { should validate_presence_of :name }
  it { should validate_presence_of :branch }
  it { should validate_presence_of :maintainer }

  it { should have_db_index :branch_id }
  it { should have_db_index :maintainer_id }
end
