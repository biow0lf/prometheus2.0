require 'rails_helper'

describe Team do
  context 'Associations' do
    it { is_expected.to belong_to :branch }
    it { is_expected.to belong_to :maintainer }
  end

  context 'Validation' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :branch }
    it { is_expected.to validate_presence_of :maintainer }
  end

  context 'DB Indexes' do
    it { is_expected.to have_db_index :branch_id }
    it { is_expected.to have_db_index :maintainer_id }
  end
end
