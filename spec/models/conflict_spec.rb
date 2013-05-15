require 'spec_helper'

describe Conflict do
  describe 'Associations' do
    it { should belong_to :package }
  end

  describe 'Validation' do
    it { should validate_presence_of :package }
    it { should validate_presence_of :name }
  end

  it { should have_db_index :package_id }
end
