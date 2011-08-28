require 'spec_helper'

describe Srpm do
  it { should belong_to :branch }
  it { should belong_to :group }
  it { should have_many :packages }
  it { should have_many :changelogs }
  it { should have_one :leader }
  it { should have_one(:maintainer).through(:leader) }
  it { should have_many :acls }
  it { should have_many :repocops }
  it { should have_one :specfile }
  it { should have_one :repocop_patch }
  it { should have_many :patches }

  pending "test :dependent => :destroy for :packages, :changelogs, :leaders, :acls"
  pending "test :foreign_key => 'srcname', :primary_key => 'name' for :repocops"

  it { should validate_presence_of :branch }
  it { should validate_presence_of :group }
  it { should validate_presence_of :md5 }

  it { should have_db_index :branch_id }
  it { should have_db_index :group_id }
  it { should have_db_index :name }

  it "should return Srpm.name on .to_param" do
    branch = Branch.create!(:name => 'Sisyphus', :vendor => 'ALT Linux')
    group0 = Group.create!(:name => 'Graphical desktop', :branch_id => branch.id)
    group = Group.create!(:name => 'Other', :branch_id => branch.id)
    group.move_to_child_of(group0)

    Srpm.create!(:branch_id => branch.id,
                :name => 'openbox',
                :version => '3.4.11.1',
                :release => 'alt1.1.1',
                :summary => 'short description',
                :description => 'long description',
                :group_id => group.id,
                :license => 'GPLv2+',
                :url => 'http://openbox.org/',
                :size => 831617,
                :filename => 'openbox-3.4.11.1-alt1.1.1.src.rpm',
                :md5 => 'f87ff0eaa4e16b202539738483cd54d1',
                :buildtime => '2010-11-24 23:58:02 UTC').to_param.should == 'openbox'
  end
end
