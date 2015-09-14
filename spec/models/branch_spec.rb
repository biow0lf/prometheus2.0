require 'rails_helper'

describe Branch do
  context 'Validation' do
    specify { should validate_presence_of :name }
    specify { should validate_presence_of :vendor }
  end

  context 'Associations' do
    specify { should have_many :srpms }
    specify { should have_many(:changelogs).through(:srpms) }
    specify { should have_many(:packages).through(:srpms) }
    specify { should have_many :groups }
    specify { should have_many :teams }
    specify { should have_many :mirrors }
    specify { should have_many(:patches).through(:srpms) }
    specify { should have_many(:sources).through(:srpms) }
    specify { should have_many(:ftbfs).class_name('Ftbfs') }
    specify { should have_many :repocops }
    specify { should have_many :repocop_patches }
  end

  it 'should return Branch#name on #to_param' do
    expect(Branch.new(name: 'Sisyphus').to_param).to eq('Sisyphus')
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
