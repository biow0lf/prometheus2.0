require 'rails_helper'

describe Conflict do
  it { should be_a(ApplicationRecord) }

  it { should belong_to(:package) }

  it { should validate_presence_of(:name) }

  it { should have_db_index(:package_id) }
end
