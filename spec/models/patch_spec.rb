require 'spec_helper'

describe Patch, :type => :model do
  describe 'Associations' do
    it { is_expected.to belong_to :branch }
    it { is_expected.to belong_to :srpm }
  end

  describe 'Validation' do
    it { is_expected.to validate_presence_of :branch }
    it { is_expected.to validate_presence_of :srpm }
    it { is_expected.to validate_presence_of :filename }
    it { is_expected.to validate_presence_of :size }
  end

  it { is_expected.to have_db_index :branch_id }
  it { is_expected.to have_db_index :srpm_id }
end
