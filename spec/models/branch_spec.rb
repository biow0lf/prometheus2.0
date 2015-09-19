require 'rails_helper'

describe Branch do
  describe 'Validation' do
    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:vendor) }
  end

  describe 'Associations' do
    it { should have_many(:srpms) }

    it { should have_many(:changelogs).through(:srpms) }

    it { should have_many(:packages).through(:srpms) }

    it { should have_many(:groups) }

    it { should have_many(:teams) }

    it { should have_many(:mirrors) }

    it { should have_many(:patches).through(:srpms) }

    it { should have_many(:sources).through(:srpms) }

    it { should have_many(:ftbfs).class_name('Ftbfs') }

    it { should have_many(:repocops) }

    it { should have_many(:repocop_patches) }
  end

  describe 'Callbacks' do
    it { should callback(:set_default_counter_value).after(:create) }

    it { should callback(:destroy_counter).after(:destroy) }
  end

  describe '#to_param' do
    subject { stub_model Branch, name: 'Sisyphus' }

    its(:to_param) { should eq('Sisyphus') }
  end

  it 'should set default value in redis for counter after create' do
    branch = create(:branch)
    expect(branch.counter.value).to eq(0)
  end

  it 'should remove counter in redis after destroy' do
    branch = create(:branch)
    branch.destroy
    expect(Redis.current.get("branch:#{ branch.id }:counter")).to be_nil
  end

  it 'should recount Branch#srpms on #recount! and save' do
    branch = create(:branch)
    branch.counter.value = 42
    expect(branch.counter.value).to eq(42)
    branch.recount!
    expect(branch.counter.value).to eq(0)
  end
end
