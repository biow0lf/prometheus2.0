require 'spec_helper'

describe Mirror, :type => :model do
  describe 'Associations' do
    it { is_expected.to belong_to :branch }
  end

  describe 'Validation' do
    it { is_expected.to validate_presence_of :branch }
    it { is_expected.to validate_presence_of :order_id }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :uri }
    it { is_expected.to validate_presence_of :protocol }
  end

  it { is_expected.to have_db_index :branch_id }
end
