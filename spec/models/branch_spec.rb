require 'spec_helper'

describe Branch do
  describe 'Validation' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :vendor }
  end

  describe 'Associations' do
    it { should have_many :srpms }
    it { should have_many(:changelogs).through(:srpms) }
    it { should have_many :packages }
    it { should have_many :groups }
    it { should have_many :teams }
    it { should have_many :mirrors }
    it { should have_many :patches }
    it { should have_many :ftbfs }
    it { should have_many :repocops }
    it { should have_many :repocop_patches }
  end

  it 'should return Branch.name on .to_param' do
    Branch.new(name: 'Sisyphus').to_param.should == 'Sisyphus'
  end

  it 'should set default value in redis for counter after create' do
    branch = FactoryGirl.create(:branch)
    branch.counter.value.should eq(0)
  end

  it 'should remove counter in redis after destroy' do
    branch = FactoryGirl.create(:branch)
    branch.destroy
    Redis.current.get("branch:#{ branch.id }:counter").should be_nil
  end

  it 'should recount Branch.srpms on recount!' do
    branch = FactoryGirl.create(:branch)
    Redis.current.set("branch:#{ branch.id }:counter", 42)
    branch.counter.value.should eq(42)
    branch.recount!.counter.value.should eq(0)
  end
end
