require 'rails_helper'

describe Srpm do
  context 'Associations' do
    it { is_expected.to belong_to :branch }
    it { is_expected.to belong_to :group }
    it { is_expected.to have_many(:packages).dependent(:destroy) }
    it { is_expected.to have_many(:changelogs).dependent(:destroy) }
    it do
      is_expected.to have_many(:repocops)
        .with_foreign_key('srcname')
        .with_primary_key('name')
    end
    it { is_expected.to have_one(:specfile).dependent(:destroy) }
    it do
      is_expected.to have_one(:repocop_patch)
        .with_foreign_key('name')
        .with_primary_key('name')
    end
    it { is_expected.to have_many(:patches).dependent(:destroy) }
    it { is_expected.to have_many(:sources).dependent(:destroy) }
    it do
      is_expected.to have_one(:builder)
        .class_name('Maintainer')
        .with_foreign_key('id')
        .with_primary_key('builder_id')
    end
  end

  context 'Validation' do
    it { is_expected.to validate_presence_of :branch }
    it { is_expected.to validate_presence_of :group }
    it { is_expected.to validate_presence_of :groupname }
    it { is_expected.to validate_presence_of :md5 }
  end

  context 'DB Indexes' do
    it { is_expected.to have_db_index :branch_id }
    it { is_expected.to have_db_index :group_id }
    it { is_expected.to have_db_index :name }
  end

  it 'should return Srpm#name on #to_param' do
    expect(Srpm.new(name: 'openbox').to_param).to eq('openbox')
  end

  it 'should import all srpms from path' do
    branch = create(:branch, name: 'Sisyphus', vendor: 'ALT Linux')
    path = '/ALT/Sisyphus/files/SRPMS/*.src.rpm'
    expect(Redis.current.get("#{ branch.name }:glibc-2.11.3-alt6.src.rpm")).to be_nil
    expect(Dir).to receive(:glob).with(path).and_return(['glibc-2.11.3-alt6.src.rpm'])
    expect(File).to receive(:exist?).with('glibc-2.11.3-alt6.src.rpm').and_return(true)
    expect(RPM).to receive(:check_md5).and_return(true)
    expect(Srpm).to receive(:import).and_return(true)

    Srpm.import_all(branch, path)
  end

  it 'should remove old srpms from database' do
    branch = create(:branch)
    group = create(:group, branch_id: branch.id)
    srpm1 = create(:srpm, branch_id: branch.id, group_id: group.id)
    Redis.current.set("#{ branch.name }:#{ srpm1.filename }", 1)
    srpm2 = create(
      :srpm,
      name: 'blackbox',
      filename: 'blackbox-1.0-alt1.src.rpm',
      branch_id: branch.id,
      group_id: group.id
    )
    Redis.current.set("#{ branch.name }:#{ srpm2.filename }", 1)
    Redis.current.sadd("#{ branch.name }:#{ srpm2.name }:acls", 'icesik')
    Redis.current.set("#{ branch.name }:#{ srpm2.name }:leader", 'icesik')

    path = '/ALT/Sisyphus/files/SRPMS/'

    expect(File).to receive(:exist?)
      .with("#{ path }openbox-3.4.11.1-alt1.1.1.src.rpm").and_return(true)
    expect(File).to receive(:exist?)
      .with("#{ path }blackbox-1.0-alt1.src.rpm").and_return(false)

    expect { Srpm.remove_old(branch, path) }
      .to change(Srpm, :count).by(-1)

    expect(Redis.current.get("#{ branch.name }:openbox-3.4.11.1-alt1.1.1.src.rpm")).to eq('1')
    expect(Redis.current.get("#{ branch.name }:blackbox-1.0-alt1.src.rpm")).to be_nil
    expect(Redis.current.get("#{ branch.name }:#{ srpm2.name }:acls")).to be_nil
    expect(Redis.current.get("#{ branch.name }:#{ srpm2.name }:leader")).to be_nil

    # TODO: add checks for sub packages, set-get-delete
  end

  it 'should increment branch.counter on srpm.save' do
    branch = create(:branch)
    group = create(:group, branch_id: branch.id)
    create(:srpm, branch_id: branch.id, group_id: group.id)
    expect(branch.counter.value).to eq(1)
  end

  it 'should decrement branch.counter on srpm.destroy' do
    branch = create(:branch)
    group = create(:group, branch_id: branch.id)
    srpm = create(:srpm, branch_id: branch.id, group_id: group.id)
    srpm.destroy
    expect(branch.counter.value).to eq(0)
  end
end
