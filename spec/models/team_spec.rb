require 'rails_helper'

describe Team do
  context 'Associations' do
    it { should belong_to(:branch) }

    it { should belong_to(:maintainer) }
  end

  context 'Validation' do
    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:branch) }

    it { should validate_presence_of(:maintainer) }
  end

  context 'DB Indexes' do
    it { should have_db_index(:branch_id) }

    it { should have_db_index(:maintainer_id) }
  end
end
