require 'rails_helper'
require 'rpmfile'

describe Srpm do
  describe 'Associations' do
    it { should belong_to(:branch) }

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
    end

    it do
      should have_one(:repocop_patch)
        .with_primary_key('name')
        .with_foreign_key('name')
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
        .with_foreign_key('repo')
    end
  end

  describe 'Validation' do
    it { should validate_presence_of(:branch) }

    it { should validate_presence_of(:group) }

    it { should validate_presence_of(:groupname) }

    it { should validate_presence_of(:md5) }
  end

  describe 'DB Indexes' do
    it { should have_db_index(:branch_id) }

    it { should have_db_index(:group_id) }

    it { should have_db_index(:name) }
  end

  # describe 'delegated methods' do
  #   it { should delegate_method(:name).to(:branch).with_prefix(true) }
  # end

  # set :acls

  # value :leader

  describe '#to_param' do
    subject { stub_model Srpm, name: 'openbox' }

    its(:to_param) { should eq('openbox') }
  end

  it 'should import srpm file' do
    branch = create(:branch)
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
    expect(rpm).to receive(:buildtime).and_return(Time.at(1315301838))
    expect(rpm).to receive(:changelogname)
      .and_return('Igor Zubkov <icesik@altlinux.org> 3.4.11.1-alt1.1.1')
    expect(rpm).to receive(:changelogtext).and_return('- 3.4.11.1')
    expect(rpm).to receive(:changelogtime).and_return(Time.at(1312545600))
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

    expect { Srpm.import(branch, rpm, file) }
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
    expect(srpm.buildtime).to eq(Time.at(1315301838))
    expect(srpm.changelogtime).to eq(Time.at(1312545600))
    expect(srpm.changelogname)
      .to eq('Igor Zubkov <icesik@altlinux.org> 3.4.11.1-alt1.1.1')
    expect(srpm.changelogtext).to eq('- 3.4.11.1')
    expect(srpm.filename).to eq('openbox-3.4.11.1-alt1.1.1.src.rpm')
    expect(srpm.size).to eq(831_617)
    expect(srpm.md5).to eq(md5)
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
end
