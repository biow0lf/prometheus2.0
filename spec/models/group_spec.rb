require 'spec_helper'

describe Group do
  describe 'Associations' do
    it { should belong_to :branch }
    it { should have_many :srpms }
    it { should have_many :packages }
  end

  describe 'Validation' do
    it { should validate_presence_of :branch }
    it { should validate_presence_of :name }
  end

  it { should have_db_index :branch_id }
  it { should have_db_index :parent_id }

  it 'should return full group name on #full_name' do
    branch = FactoryGirl.create(:branch)
    Group.import(branch, 'System/Configuration/Boot and Init')
    Group.all.last.full_name.should == 'System/Configuration/Boot and Init'
  end

  it 'should import group "Shells"' do
    branch = FactoryGirl.create(:branch)
    Group.import(branch, 'Shells')
    Group.all.count.should == 1
    Group.all.first.branch_id.should == branch.id
    Group.all.first.name.should == 'Shells'
    Group.all.first.parent_id.should be_nil
  end

  it 'should import group "Archiving/Backup"' do
    branch = FactoryGirl.create(:branch)
    Group.import(branch, 'Archiving/Backup')

    groups = Group.all.order('name ASC')

    groups.count.should == 2

    groups.first.branch_id.should == branch.id
    groups.first.name.should == 'Archiving'
    groups.first.parent_id.should be_nil

    groups.second.branch_id.should == branch.id
    groups.second.name.should == 'Backup'
    groups.second.parent_id.should == Group.all.first.id
  end

  it 'should import group "System/Configuration/Boot and Init"' do
    branch = FactoryGirl.create(:branch)
    Group.import(branch, 'System/Configuration/Boot and Init')

    groups = Group.all.order('name ASC')

    groups.count.should == 3

    groups.first.branch_id.should == branch.id
    groups.first.name.should == 'Boot and Init'
    groups.first.parent_id.should == groups.second.id

    groups.second.branch_id.should == branch.id
    groups.second.name.should == 'Configuration'
    groups.second.parent_id.should == groups.third.id

    groups.third.branch_id.should == branch.id
    groups.third.name.should == 'System'
    groups.third.parent_id.should be_nil
  end

  it 'should return group instance with id for "Boot and Init"' do
    branch = FactoryGirl.create(:branch)
    Group.import(branch, 'System/Configuration/Boot and Init')
    Group.in_branch(branch, 'System/Configuration/Boot and Init').name.should == 'Boot and Init'
  end
end
