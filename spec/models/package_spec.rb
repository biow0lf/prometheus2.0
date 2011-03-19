require 'spec_helper'

describe Package do
  it { should belong_to :branch }
  it { should belong_to :srpm }
  it { should belong_to :group }

  it { should validate_presence_of :srpm_id }
  it { should validate_presence_of :branch_id }
  it { should validate_presence_of :group_id }

  it { should have_db_index :arch }
  it { should have_db_index :branch_id }
  it { should have_db_index :group_id }
  it { should have_db_index :sourcepackage }
  it { should have_db_index :srpm_id }

  it { should have_many :provides }
  it { should have_many :requires }
  it { should have_many :obsoletes }
  it { should have_many :conflicts }
end
