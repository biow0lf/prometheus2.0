require 'spec_helper'

describe Bug do
  it { should have_db_index :assigned_to }
  it { should have_db_index :bug_status }
  it { should have_db_index :product }
end
