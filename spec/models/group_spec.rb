require 'spec_helper'

describe Group do
  it { should belong_to :branch }
  it { should have_many :srpms }
  it { should have_many :packages }

  it { should validate_presence_of :branch_id }
  it { should validate_presence_of :name }

  it { should have_db_index :branch_id }
end
