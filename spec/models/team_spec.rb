require 'rails_helper'

describe Team do
  it { should be_a(ApplicationRecord) }

  context 'Associations' do
    it { should belong_to(:branch) }

    it { should belong_to(:maintainer) }
  end

  it { should validate_presence_of(:name) }

  context 'DB Indexes' do
    it { should have_db_index(:branch_id) }

    it { should have_db_index(:maintainer_id) }
  end
end
