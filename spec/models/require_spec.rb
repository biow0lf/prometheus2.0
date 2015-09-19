require 'rails_helper'

describe Require do
  context 'Associations' do
    it { should belong_to :package }
  end

  context 'Validation' do
    it { should validate_presence_of :package }
    it { should validate_presence_of :name }
  end

  it { should have_db_index :package_id }
end
