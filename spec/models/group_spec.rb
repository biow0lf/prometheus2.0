# encoding: utf-8

require 'spec_helper'

describe Group do
  it { should belong_to :branch }
  it { should have_many :srpms }
  it { should have_many :packages }

  it { should validate_presence_of :branch }
  it { should validate_presence_of :name }

  it { should have_db_index :branch_id }
  it { should have_db_index :parent_id }

  it "should return full group name on #full_name" do
    branch = FactoryGirl.create(:branch)
    Group.import(branch, 'System/Configuration/Boot and Init')
    Group.all.last.full_name.should == 'System/Configuration/Boot and Init'
  end

  it "should import group 'Shells'" do
    branch = FactoryGirl.create(:branch)
    Group.import(branch, 'Shells')
    Group.all.count.should == 1
    Group.all.first.branch_id.should == branch.id
    Group.all.first.name.should == 'Shells'
    Group.all.first.parent_id.should be_nil
  end

  it "should import group 'Archiving/Backup'" do
    branch = FactoryGirl.create(:branch)
    Group.import(branch, 'Archiving/Backup')
    Group.all.count.should == 2
    Group.all.first.branch_id.should == branch.id
    Group.all.first.name.should == 'Archiving'
    Group.all.first.parent_id.should be_nil
    Group.all.second.branch_id.should == branch.id
    Group.all.second.name.should == 'Backup'
    Group.all.second.parent_id.should == Group.all.first.id
  end

  it "should import group 'System/Configuration/Boot and Init'" do
    branch = FactoryGirl.create(:branch)
    Group.import(branch, 'System/Configuration/Boot and Init')
    Group.all.count.should == 3
    Group.all.first.branch_id.should == branch.id
    Group.all.first.name.should == 'System'
    Group.all.first.parent_id.should be_nil
    Group.all.second.branch_id.should == branch.id
    Group.all.second.name.should == 'Configuration'
    Group.all.second.parent_id.should == Group.all.first.id
    Group.all.third.branch_id.should == branch.id
    Group.all.third.name.should == 'Boot and Init'
    Group.all.third.parent_id.should == Group.all.second.id
  end

  it "should allow translate Group.name to russian" do
    I18n.locale = :en
    branch = FactoryGirl.create(:branch)
    Group.create(branch_id: branch.id, name: 'Toys')
    I18n.locale = :ru
    group = Group.all.first
    group.name = 'Развлечения'
    group.save!
    I18n.locale = :en
    Group.first.name.should == 'Toys'
    I18n.locale = :ru
    Group.first.name.should == 'Развлечения'
  end

  it "should return group instance with id for 'Boot and Init'" do
    branch = FactoryGirl.create(:branch)
    Group.import(branch, 'System/Configuration/Boot and Init')
    Group.in_branch(branch, 'System/Configuration/Boot and Init').name.should == 'Boot and Init'
  end
end
