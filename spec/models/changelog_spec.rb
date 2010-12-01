require 'spec_helper'

describe Changelog do
  context "[validation]" do
    it { should belong_to :srpm }

    it { should validate_presence_of :srpm_id }
    it { should validate_presence_of :changelogtime }
    it { should validate_presence_of :changelogname }
    it { should validate_presence_of :changelogtext }
    
    it { should have_db_index :srpm_id }
  end
end
