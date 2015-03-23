require 'rails_helper'

describe Branch do
  context 'Validation' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :vendor }
  end

  context 'Associations' do
    it { is_expected.to have_many :srpms }
    it { is_expected.to have_many(:changelogs).through(:srpms) }
    it { is_expected.to have_many :packages }
    it { is_expected.to have_many :groups }
    it { is_expected.to have_many :teams }
    it { is_expected.to have_many :mirrors }
    it { is_expected.to have_many(:patches).through(:srpms) }
    it { is_expected.to have_many(:sources).through(:srpms) }
    it { is_expected.to have_many(:ftbfs).class_name('Ftbfs') }
    it { is_expected.to have_many :repocops }
    it { is_expected.to have_many :repocop_patches }
  end

  it 'should return Branch#name on #to_param' do
    expect(Branch.new(name: 'Sisyphus').to_param).to eq('Sisyphus')
  end

  it 'should set default value in redis for counter after create' do
    branch = create(:branch, name: 'Sisyphus', vendor: 'ALT Linux')
    expect(branch.counter.value).to eq(0)
  end

  it 'should remove counter in redis after destroy' do
    branch = create(:branch, name: 'Sisyphus', vendor: 'ALT Linux')
    branch.destroy
    expect(Redis.current.get("branch:#{ branch.id }:counter")).to be_nil
  end

  it 'should recount Branch#srpms on #recount! and save' do
    branch = create(:branch, name: 'Sisyphus', vendor: 'ALT Linux')
    branch.counter.value = 42
    expect(branch.counter.value).to eq(42)
    branch.recount!
    expect(branch.counter.value).to eq(0)
  end
end
