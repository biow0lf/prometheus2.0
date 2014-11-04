require 'spec_helper'

describe Srpm, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to :branch }
    it { is_expected.to belong_to :group }
    it { is_expected.to have_many :packages }
    it { is_expected.to have_many :changelogs }
    it { is_expected.to have_many :repocops }
    it { is_expected.to have_one :specfile }
    it { is_expected.to have_one :repocop_patch }
    it { is_expected.to have_many :patches }
    it { is_expected.to have_many :sources }
  end

  # pending "test :dependent => :destroy for :packages, :changelogs, :acls"
  # pending "test :foreign_key => 'srcname', :primary_key => 'name' for :repocops"

  describe 'Validation' do
    it { is_expected.to validate_presence_of :branch }
    it { is_expected.to validate_presence_of :group }
    it { is_expected.to validate_presence_of :groupname }
    it { is_expected.to validate_presence_of :md5 }
  end

  it { is_expected.to have_db_index :branch_id }
  it { is_expected.to have_db_index :group_id }
  it { is_expected.to have_db_index :name }

  it 'should return Srpm.name on .to_param' do
    expect(Srpm.new(name: 'openbox').to_param).to eq('openbox')
  end

  it 'should import srpm file' do
    branch = FactoryGirl.create(:branch)
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    md5 = "f87ff0eaa4e16b202539738483cd54d1  /Sisyphus/files/SRPMS/#{ file }"
    maintainer = Maintainer.create!(login: 'icesik', email: 'icesik@altlinux.org', name: 'Igor Zubkov')

    expect(Srpm).to receive(:`).with("/usr/bin/md5sum #{ file }").and_return(md5)
    expect(Srpm).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{NAME}' #{ file }").and_return('openbox')
    expect(Srpm).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{VERSION}' #{ file }").and_return('3.4.11.1')
    expect(Srpm).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{RELEASE}' #{ file }").and_return('alt1.1.1')
    expect(Srpm).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{EPOCH}' #{ file }").and_return('(none)')
    expect(Srpm).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{SUMMARY}' #{ file }").and_return('short description')
    expect(Srpm).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{GROUP}' #{ file }").and_return('Graphical desktop/Other')

    expect(Srpm).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{PACKAGER}' #{ file }").and_return('Igor Zubkov <icesik@altlinux.org>')

    expect(Maintainer).to receive(:import).with('Igor Zubkov <icesik@altlinux.org>')

    expect(MaintainerTeam).not_to receive(:import).with('Igor Zubkov <icesik@altlinux.org>')

    expect(Srpm).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{LICENSE}' #{ file }").and_return('GPLv2+')
    expect(Srpm).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{URL}' #{ file }").and_return('http://openbox.org/')
    expect(Srpm).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{DESCRIPTION}' #{ file }").and_return('long description')
    expect(Srpm).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{VENDOR}' #{ file }").and_return('ALT Linux Team')
    expect(Srpm).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{DISTRIBUTION}' #{ file }").and_return('ALT Linux')
    expect(Srpm).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{BUILDTIME}' #{ file }").and_return('1315301838')
    expect(Srpm).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{CHANGELOGTIME}' #{ file }").and_return('1312545600')
    expect(Srpm).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{CHANGELOGNAME}' #{ file }").and_return('Igor Zubkov <icesik@altlinux.org> 3.4.11.1-alt1.1.1')
    expect(Srpm).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{CHANGELOGTEXT}' #{ file }").and_return('- 3.4.11.1')

    expect(File).to receive(:size).with(file).and_return(831_617)

    expect(Specfile).to receive(:import).and_return(true)
    expect(Changelog).to receive(:import).and_return(true)
    expect(Patch).to receive(:import).and_return(true)
    expect(Source).to receive(:import).and_return(true)

    expect {
      Srpm.import(branch, file)
    }.to change { Srpm.count }.from(0).to(1)

    srpm = Srpm.first
    expect(srpm.name).to eq('openbox')
    expect(srpm.version).to eq('3.4.11.1')
    expect(srpm.release).to eq('alt1.1.1')
    expect(srpm.epoch).to be_nil
    expect(srpm.summary).to eq('short description')
    expect(srpm.group.full_name).to eq('Graphical desktop/Other')
    expect(srpm.groupname).to eq('Graphical desktop/Other')
    expect(srpm.license).to eq('GPLv2+')
    expect(srpm.url).to eq('http://openbox.org/')
    expect(srpm.description).to eq('long description')
    expect(srpm.vendor).to eq('ALT Linux Team')
    expect(srpm.distribution).to eq('ALT Linux')
    # FIXME:
    # srpm.buildtime.should eq(Time.at(1_315_301_838))
    # srpm.changelogtime.should eq(Time.at(1_312_545_600))
    expect(srpm.changelogname).to eq('Igor Zubkov <icesik@altlinux.org> 3.4.11.1-alt1.1.1')
    expect(srpm.changelogtext).to eq('- 3.4.11.1')
    expect(srpm.filename).to eq('openbox-3.4.11.1-alt1.1.1.src.rpm')

    expect(Redis.current.get("#{ branch.name }:#{ srpm.filename }")).to eq('1')
  end

  it 'should import all srpms from path' do
    branch = FactoryGirl.create(:branch)
    path = '/ALT/Sisyphus/files/SRPMS/*.src.rpm'
    expect(Redis.current.get("#{ branch.name }:glibc-2.11.3-alt6.src.rpm")).to be_nil
    expect(Dir).to receive(:glob).with(path).and_return(['glibc-2.11.3-alt6.src.rpm'])
    expect(File).to receive(:exist?).with('glibc-2.11.3-alt6.src.rpm').and_return(true)
    expect(RPM).to receive(:check_md5).and_return(true)
    expect(Srpm).to receive(:import).and_return(true)

    Srpm.import_all(branch, path)
  end

  it 'should remove old srpms from database' do
    branch = FactoryGirl.create(:branch)
    group = FactoryGirl.create(:group, branch_id: branch.id)
    srpm1 = FactoryGirl.create(:srpm, branch_id: branch.id, group_id: group.id)
    Redis.current.set("#{ branch.name }:#{ srpm1.filename }", 1)
    srpm2 = FactoryGirl.create(:srpm, name: 'blackbox', filename: 'blackbox-1.0-alt1.src.rpm', branch_id: branch.id, group_id: group.id)
    Redis.current.set("#{ branch.name }:#{ srpm2.filename }", 1)
    Redis.current.sadd("#{ branch.name }:#{ srpm2.name }:acls", "icesik")
    Redis.current.set("#{ branch.name }:#{ srpm2.name }:leader", "icesik")

    path = '/ALT/Sisyphus/files/SRPMS/'

    expect(File).to receive(:exists?).with("#{ path }openbox-3.4.11.1-alt1.1.1.src.rpm").and_return(true)
    expect(File).to receive(:exists?).with("#{ path }blackbox-1.0-alt1.src.rpm").and_return(false)

    expect {
      Srpm.remove_old(branch, path)
    }.to change { Srpm.count }.from(2).to(1)

    expect(Redis.current.get("#{ branch.name }:openbox-3.4.11.1-alt1.1.1.src.rpm")).to eq('1')
    expect(Redis.current.get("#{ branch.name }:blackbox-1.0-alt1.src.rpm")).to be_nil
    expect(Redis.current.get("#{ branch.name }:#{ srpm2.name }:acls")).to be_nil
    expect(Redis.current.get("#{ branch.name }:#{ srpm2.name }:leader")).to be_nil

    # TODO: add checks for sub packages, set-get-delete
  end

  it 'should increment branch.counter on srpm.save' do
    branch = FactoryGirl.create(:branch)
    group = FactoryGirl.create(:group, branch_id: branch.id)
    FactoryGirl.create(:srpm, branch_id: branch.id, group_id: group.id)
    expect(branch.counter.value).to eq(1)
  end

  it 'should decrement branch.counter on srpm.destroy' do
    branch = FactoryGirl.create(:branch)
    group = FactoryGirl.create(:group, branch_id: branch.id)
    srpm = FactoryGirl.create(:srpm, branch_id: branch.id, group_id: group.id)
    srpm.destroy
    expect(branch.counter.value).to eq(0)
  end
end
