require 'spec_helper'

describe Branch, :type => :model do
  describe 'Validation' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :vendor }
  end

  describe 'Associations' do
    it { is_expected.to have_many :srpms }
    it { is_expected.to have_many(:changelogs).through(:srpms) }
    it { is_expected.to have_many :packages }
    it { is_expected.to have_many :groups }
    it { is_expected.to have_many :teams }
    it { is_expected.to have_many :mirrors }
    it { is_expected.to have_many :patches }
    it { is_expected.to have_many :ftbfs }
    it { is_expected.to have_many :repocops }
    it { is_expected.to have_many :repocop_patches }
  end

  it 'should return Branch.name on .to_param' do
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

  it 'should recount Branch.srpms on recount!' do
    branch = FactoryGirl.create(:branch)
    Redis.current.set("branch:#{ branch.id }:counter", 42)
    expect(branch.counter.value).to eq(42)
    expect(branch.recount!.counter.value).to eq(0)
  end
end
