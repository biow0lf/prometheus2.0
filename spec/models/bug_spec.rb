require 'rails_helper'

describe Bug do
  context 'DB Indexes' do
    it { is_expected.to have_db_index :assigned_to }
    it { is_expected.to have_db_index :bug_status }
    it { is_expected.to have_db_index :product }
  end
end
