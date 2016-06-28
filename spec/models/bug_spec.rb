require 'rails_helper'

describe Bug do
  it { should be_a(ApplicationRecord) }

  describe 'Validations' do
    it { should validate_presence_of(:bug_id) }
  end

  describe 'DB Indexes' do
    it { should have_db_index(:assigned_to) }

    it { should have_db_index(:bug_status) }

    it { should have_db_index(:product) }
  end
end
