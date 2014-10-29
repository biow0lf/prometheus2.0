require 'spec_helper'

describe Team, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to :branch }
    it { is_expected.to belong_to :maintainer }
  end

  describe 'Validation' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :branch }
    it { is_expected.to validate_presence_of :maintainer }
  end

  it { is_expected.to have_db_index :branch_id }
  it { is_expected.to have_db_index :maintainer_id }
end
