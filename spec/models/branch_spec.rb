require 'rails_helper'

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
    it { should have_many(:ftbfs).class_name('Ftbfs') }
    it { should have_many :repocops }
    it { should have_many :repocop_patches }
  end

  it 'should return branch name on #to_param' do
    expect(Branch.new(name: 'Sisyphus').to_param).to eq('Sisyphus')
  end

  it 'should set default value in redis for counter after create' do
    branch = FactoryGirl.create(:branch)
    expect(branch.counter.value).to eq(0)
  end

  it 'should remove counter in redis after destroy' do
    branch = FactoryGirl.create(:branch)
    branch.destroy
    expect(Redis.current.get("branch:#{ branch.id }:counter")).to be_nil
  end

  it 'should recount Branch.srpms on #recount! and save' do
    branch = FactoryGirl.create(:branch)
    branch.counter.value = 42
    expect(branch.counter.value).to eq(42)
    branch.recount!
    expect(branch.counter.value).to eq(0)
  end
end
