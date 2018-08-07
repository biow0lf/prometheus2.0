# frozen_string_literal: true

require 'rails_helper'
require 'rpmfile'

describe Srpm do
  it { should be_a(ApplicationRecord) }

  let(:named_srpm) { create(:named_srpm) }
  let(:srpm) { named_srpm.srpm }
  let(:branch) { create(:branch, :with_paths, name: 'Sisyphus', vendor: 'ALT Linux') }
  let(:branch_path) { branch.branch_paths.source.first }

  subject { srpm }

  before do
    # fix "uninitialized constant RSpec::Support::Differ"
    allow(File).to receive(:exist?).and_call_original
  end

  describe 'Associations' do
    it { should belong_to(:group) }

    it { should have_many(:packages).dependent(:destroy) }

    it { should have_many(:changelogs).dependent(:destroy) }

    it { should have_one(:specfile).dependent(:destroy) }

    it { should have_many(:patches).dependent(:destroy) }

    it { should have_many(:sources).dependent(:destroy) }

    it do
      should have_many(:repocops)
        .order(name: :asc)
        .with_primary_key('name')
        .with_foreign_key('srcname')
        .dependent(:destroy)
    end

    it do
      should have_one(:repocop_patch)
        .with_primary_key('name')
        .with_foreign_key('name')
        .dependent(:destroy)
    end

    it do
      should have_one(:builder)
        .class_name('Maintainer')
        .with_primary_key('builder_id')
        .with_foreign_key('id')
    end

    it do
      should have_many(:gears)
        .order(lastchange: :desc)
        .with_primary_key('name')
        .with_foreign_key('repo') # .dependent(:destroy)
    end

    it { is_expected.to_not have_db_column(:branch_id) }
    it { is_expected.to_not have_db_column(:filename) }
    it { is_expected.to_not have_db_column(:alias) }

    it { is_expected.to have_many(:branches).through(:named_srpms) }
    it { is_expected.to have_many(:named_srpms).dependent(:destroy) }
  end

  describe 'Validation' do
    it { is_expected.to validate_presence_of(:groupname) }
    it { is_expected.to validate_presence_of(:md5) }
    it { is_expected.to validate_presence_of(:buildtime) }
  end

  # describe 'delegated methods' do
  #   it { should delegate_method(:name).to(:branch).with_prefix(true) }
  # end

  # set :acls

  # value :leader

  describe 'Callbacks' do
    it { should callback(:add_filename_to_cache).after(:save) }

    it { should callback(:increment_branch_counter).after(:create) }

    it { should callback(:decrement_branch_counter).after(:destroy) }

    it { should callback(:remove_filename_from_cache).after(:destroy) }

    it { should callback(:remove_acls_from_cache).after(:destroy) }

    it { should callback(:remove_leader_from_cache).after(:destroy) }
  end

  describe '#to_param' do
    subject { stub_model Srpm, name: 'openbox' }

    its(:to_param) { should eq('openbox') }
  end

  it 'should import srpm file' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    md5 = 'f87ff0eaa4e16b202539738483cd54d1'
    maintainer = Maintainer.create!(
      login: 'icesik',
      email: 'icesik@altlinux.org',
      name: 'Igor Zubkov'
    )
    rpm = RPMFile::Source.new(file)

    expect(rpm).to receive(:name).and_return('openbox')
    expect(rpm).to receive(:version).and_return('3.4.11.1')
    expect(rpm).to receive(:release).and_return('alt1.1.1')
    expect(rpm).to receive(:epoch).and_return(nil)
    expect(rpm).to receive(:summary).and_return('short description')
    expect(rpm).to receive(:group).and_return('Graphical desktop/Other')
    expect(rpm).to receive(:license).and_return('GPLv2+')
    expect(rpm).to receive(:url).and_return('http://openbox.org/')
    expect(rpm).to receive(:packager)
      .and_return('Igor Zubkov <icesik@altlinux.org>')
    expect(rpm).to receive(:vendor).and_return('ALT Linux Team')
    expect(rpm).to receive(:distribution).and_return('ALT Linux')
    expect(rpm).to receive(:description).and_return('long description')
    # TODO: add buildhost
    expect(rpm).to receive(:buildtime).and_return(Time.at(1_315_301_838))
    expect(rpm).to receive(:changelogname)
      .and_return('Igor Zubkov <icesik@altlinux.org> 3.4.11.1-alt1.1.1')
    expect(rpm).to receive(:changelogtext).and_return('- 3.4.11.1')
    expect(rpm).to receive(:changelogtime).and_return(Time.at(1_312_545_600))
    expect(rpm).to receive(:md5).and_return(md5)
    expect(rpm).to receive(:size).and_return(831_617)
    expect(rpm).to receive(:filename).and_return(file)

    expect(Maintainer).to receive(:import)
      .with('Igor Zubkov <icesik@altlinux.org>')

    # TODO: recheck this later
    # expect(MaintainerTeam).to_not receive(:import)
    #   .with('Igor Zubkov <icesik@altlinux.org>')

    expect(Specfile).to receive(:import).and_return(true)
    expect(Changelog).to receive(:import).and_return(true)
    expect(Patch).to receive(:import).and_return(true)
    expect(Source).to receive(:import).and_return(true)

    expect { Srpm.import(branch_path, rpm, file) }
      .to change(Srpm, :count).by(1)

    srpm = Srpm.first
    expect(srpm.name).to eq('openbox')
    expect(srpm.version).to eq('3.4.11.1')
    expect(srpm.release).to eq('alt1.1.1')
    expect(srpm.epoch).to be_nil
    expect(srpm.summary).to eq('short description')
    # expect(srpm.group.full_name).to eq('Graphical desktop/Other')
    expect(srpm.groupname).to eq('Graphical desktop/Other')
    expect(srpm.license).to eq('GPLv2+')
    expect(srpm.url).to eq('http://openbox.org/')
    expect(srpm.description).to eq('long description')
    expect(srpm.vendor).to eq('ALT Linux Team')
    expect(srpm.distribution).to eq('ALT Linux')
    expect(srpm.buildtime).to eq(Time.at(1_315_301_838))
    expect(srpm.changelogtime).to eq(Time.at(1_312_545_600))
    expect(srpm.changelogname)
      .to eq('Igor Zubkov <icesik@altlinux.org> 3.4.11.1-alt1.1.1')
    expect(srpm.changelogtext).to eq('- 3.4.11.1')
    expect(srpm.size).to eq(831_617)
    expect(srpm.md5).to eq(md5)
    expect(srpm.named_srpms.first.name).to eq('openbox-3.4.11.1-alt1.1.1.src.rpm')
  end

  it 'should import all srpms from path' do
    path = '/ALT/Sisyphus/files/SRPMS/*.src.rpm'
    branch = create(:branch, name: 'Sisyphus', vendor: 'ALT Linux')
    _branch_path = create(:src_branch_path, path: '/ALT/Sisyphus/files/SRPMS/', branch: branch)
    expect(Redis.current.get("#{ branch.name }:glibc-2.11.3-alt6.src.rpm")).to be_nil
    expect(Dir).to receive(:glob).with(path).and_return(['glibc-2.11.3-alt6.src.rpm'])
    expect(File).to receive(:exist?).with('glibc-2.11.3-alt6.src.rpm').and_return(true)
    expect(RPMCheckMD5).to receive(:check_md5).and_return(true)
    expect(Srpm).to receive(:import).and_return(true)

    Srpm.import_all(branch)
  end

  # private methods

  describe '#add_filename_to_cache' do
    it { expect { subject.send(:add_filename_to_cache) }.not_to raise_error }
  end

  describe '#increment_branch_counter' do
    subject { create(:srpm) }

    specify { expect { subject.send(:increment_branch_counter) }.not_to raise_error }
  end

  describe '#decrement_branch_counter' do
    subject { create(:srpm) }

    specify { expect { subject.send(:decrement_branch_counter) }.not_to raise_error }
  end

  describe '#remove_filename_from_cache' do
    subject { create(:srpm) }

    specify { expect { subject.send(:remove_filename_from_cache) }.not_to raise_error }
  end

  describe '#remove_acls_from_cache' do
    subject { create(:srpm) }

    specify { expect { subject.send(:remove_acls_from_cache) }.not_to raise_error }
  end

  describe '#remove_leader_from_cache' do
    subject { create(:srpm) }

    specify { expect { subject.send(:remove_leader_from_cache) }.not_to raise_error }
  end

  describe '#by_branch' do
    before do
      create_list(:named_srpm, 10, branch: branch)
      create(:branch)
      create_list(:named_srpm, 10)
    end

    it { expect(described_class.by_branch_name(branch.name).count).to eq(10)  }
  end
end
