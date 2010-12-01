require 'spec_helper'

describe Team do
  context "[validation]" do
    it { should belong_to :branch }
    it { should belong_to :maintainer }
    
    it { should validate_presence_of :name }
    it { should validate_presence_of :branch_id }
    it { should validate_presence_of :maintainer_id }
    
    it { should have_db_index :branch_id }
    it { should have_db_index :maintainer_id }
  end
end
