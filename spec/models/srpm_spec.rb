require 'spec_helper'

describe Srpm do
  context "[validation]" do
    it { should belong_to :branch }
    it { should belong_to :group }
    it { should have_many :packages }
    it { should have_many :changelogs }
    it { should have_one :leader }
    it { should have_one(:maintainer).through(:leader) }
    it { should have_many :acls }
    it { should have_many :repocops }

    pending "test :dependent => :destroy for :packages, :changelogs, :leaders, :acls"
    pending "test :foreign_key => 'srcname', :primary_key => 'name' for :repocops"

    it { should validate_presence_of :branch_id }
    it { should validate_presence_of :group_id }
    
    it { should have_db_index :branch_id }
    it { should have_db_index :group_id }
    it { should have_db_index :name }
  end
end
