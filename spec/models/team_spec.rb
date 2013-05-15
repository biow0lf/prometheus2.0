require 'spec_helper'

describe Team do
  describe 'Associations' do
    it { should belong_to :branch }
    it { should belong_to :maintainer }
  end

  describe 'Validation' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :branch }
    it { should validate_presence_of :maintainer }
  end

  it { should have_db_index :branch_id }
  it { should have_db_index :maintainer_id }
end
