require 'rails_helper'

describe Require do
  context 'Associations' do
    it { is_expected.to belong_to :package }
  end

  context 'Validation' do
    it { is_expected.to validate_presence_of :package }
    it { is_expected.to validate_presence_of :name }
  end

  it { is_expected.to have_db_index :package_id }
end
