require 'spec_helper'

describe Ftbfs, :type => :model do
  describe 'Associations' do
    it { is_expected.to belong_to :branch }
    it { is_expected.to belong_to :maintainer }
  end

  describe 'Validation' do
    it { is_expected.to validate_presence_of :branch }
    it { is_expected.to validate_presence_of :maintainer }

    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :version }
    it { is_expected.to validate_presence_of :release }
    it { is_expected.to validate_presence_of :weeks }
    it { is_expected.to validate_presence_of :arch }
  end

  it { is_expected.to have_db_index :branch_id }
  it { is_expected.to have_db_index :maintainer_id }
end
