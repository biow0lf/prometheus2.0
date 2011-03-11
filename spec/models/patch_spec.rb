require 'spec_helper'

describe Patch do
  it { should belong_to :branch }
  it { should belong_to :srpm }

  it { should validate_presence_of :branch_id }
  it { should validate_presence_of :srpm_id }
  it { should validate_presence_of :patch }

  it { should have_db_index :branch_id }
  it { should have_db_index :srpm_id }
end
