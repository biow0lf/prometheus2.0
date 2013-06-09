require 'spec_helper'

describe Srpm do
  describe 'Associations' do
    it { should belong_to :branch }
    it { should belong_to :group }
    it { should have_many :packages }
    it { should have_many :changelogs }
    it { should have_many :repocops }
    it { should have_one :specfile }
    it { should have_one :repocop_patch }
    it { should have_many :patches }
    it { should have_many :sources }
  end

  # pending "test :dependent => :destroy for :packages, :changelogs, :acls"
  # pending "test :foreign_key => 'srcname', :primary_key => 'name' for :repocops"

  describe 'Validation' do
    it { should validate_presence_of :branch }
    it { should validate_presence_of :group }
    it { should validate_presence_of :groupname }
    it { should validate_presence_of :md5 }
  end

  it { should have_db_index :branch_id }
  it { should have_db_index :group_id }
  it { should have_db_index :name }

  it 'should return Srpm.name on .to_param' do
    branch = FactoryGirl.create(:branch)
    group0 = Group.create!(name: 'Graphical desktop', branch_id: branch.id)
    group = Group.create!(name: 'Other', branch_id: branch.id)
    group.move_to_child_of(group0)

    Srpm.create!(branch_id: branch.id,
                 name: 'openbox',
                 version: '3.4.11.1',
                 release: 'alt1.1.1',
                 summary: 'short description',
                 description: 'long description',
                 group_id: group.id,
                 groupname: 'Graphical desktop/Other',
                 license: 'GPLv2+',
                 url: 'http://openbox.org/',
                 size: 831617,
                 filename: 'openbox-3.4.11.1-alt1.1.1.src.rpm',
                 md5: 'f87ff0eaa4e16b202539738483cd54d1',
                 buildtime: '2010-11-24 23:58:02 UTC').to_param.should == 'openbox'
  end

  it 'should import srpm file' do
    branch = FactoryGirl.create(:branch)
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    md5 = 'f87ff0eaa4e16b202539738483cd54d1'
    maintainer = Maintainer.create!(login: 'icesik',
                                    email: 'icesik@altlinux.org',
                                    name: 'Igor Zubkov')

    rpm = mock
    Rpm.stub!(:new).and_return(rpm)
    rpm.should_receive(:name).and_return('openbox')
    rpm.should_receive(:version).and_return('3.4.11.1')
    rpm.should_receive(:release).and_return('alt1.1.1')
    rpm.should_receive(:epoch).and_return(nil)
    rpm.should_receive(:filename).and_return('openbox-3.4.11.1-alt1.1.1.src.rpm')
    rpm.should_receive(:summary).and_return('short description')
    rpm.should_receive(:group).and_return('Graphical desktop/Other')
    rpm.should_receive(:packager).and_return('Igor Zubkov <icesik@altlinux.org>')

    Maintainer.should_receive(:import).with('Igor Zubkov <icesik@altlinux.org>')

    MaintainerTeam.should_not_receive(:import).with('Igor Zubkov <icesik@altlinux.org>')

    rpm.should_receive(:license).and_return('GPLv2+')
    rpm.should_receive(:url).and_return('http://openbox.org/')
    rpm.should_receive(:description).and_return('long description')
    rpm.should_receive(:vendor).and_return('ALT Linux Team')
    rpm.should_receive(:distribution).and_return('ALT Linux')
    rpm.should_receive(:buildtime).and_return(Time.at(1315301838))
    rpm.should_receive(:changelogtime).and_return('1312545600')
    rpm.should_receive(:changelogname).and_return('Igor Zubkov <icesik@altlinux.org> 3.4.11.1-alt1.1.1')
    rpm.should_receive(:changelogtext).and_return('- 3.4.11.1')
    rpm.should_receive(:md5).and_return(md5)
    rpm.should_receive(:size).and_return('831617')

    Specfile.should_receive(:import).and_return(true)
    Changelog.should_receive(:import).and_return(true)
    Patch.should_receive(:import).and_return(true)
    Source.should_receive(:import).and_return(true)

    expect{ Srpm.import(branch, file) }.to change{ Srpm.count }.from(0).to(1)

    srpm = Srpm.first
    srpm.name.should == 'openbox'
    srpm.version.should == '3.4.11.1'
    srpm.release.should == 'alt1.1.1'
    srpm.epoch.should be_nil
    srpm.summary.should == 'short description'
    srpm.group.full_name.should == 'Graphical desktop/Other'
    srpm.groupname.should == 'Graphical desktop/Other'
    srpm.license.should == 'GPLv2+'
    srpm.url.should == 'http://openbox.org/'
    srpm.description.should == 'long description'
    srpm.vendor.should == 'ALT Linux Team'
    srpm.distribution.should == 'ALT Linux'
    srpm.buildtime.should == Time.at(1315301838)
    # TODO: change changelogtime from string to datetime
    # srpm.changelogtime.should == Time.at(1312545600)
    srpm.changelogname.should == 'Igor Zubkov <icesik@altlinux.org> 3.4.11.1-alt1.1.1'
    srpm.changelogtext.should == '- 3.4.11.1'
    srpm.filename.should == 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    srpm.md5.should == 'f87ff0eaa4e16b202539738483cd54d1'
    srpm.size.should == '831617'

    $redis.get("#{branch.name}:#{srpm.filename}").should == "1"
  end

  it 'should import all srpms from path' do
    branch = FactoryGirl.create(:branch)
    path = '/ALT/Sisyphus/files/SRPMS/*.src.rpm'
    $redis.get("#{branch.name}:glibc-2.11.3-alt6.src.rpm").should be_nil
    Dir.should_receive(:glob).with(path).and_return(['glibc-2.11.3-alt6.src.rpm'])
    File.should_receive(:exist?).with('glibc-2.11.3-alt6.src.rpm').and_return(true)
    Rpm.should_receive(:check_md5).and_return(true)
    Srpm.should_receive(:import).and_return(true)

    Srpm.import_all(branch, path)
  end

  it 'should remove old srpms from database' do
    branch = FactoryGirl.create(:branch)
    group = FactoryGirl.create(:group, branch_id: branch.id)
    srpm1 = FactoryGirl.create(:srpm, branch_id: branch.id, group_id: group.id)
    $redis.set("#{branch.name}:#{srpm1.filename}", 1)
    srpm2 = FactoryGirl.create(:srpm, name: 'blackbox', filename: 'blackbox-1.0-alt1.src.rpm', branch_id: branch.id, group_id: group.id)
    $redis.set("#{branch.name}:#{srpm2.filename}", 1)
    $redis.sadd("#{branch.name}:#{srpm2.name}:acls", "icesik")
    $redis.set("#{branch.name}:#{srpm2.name}:leader", "icesik")

    path = '/ALT/Sisyphus/files/SRPMS/'

    File.should_receive(:exists?).with("#{path}openbox-3.4.11.1-alt1.1.1.src.rpm").and_return(true)
    File.should_receive(:exists?).with("#{path}blackbox-1.0-alt1.src.rpm").and_return(false)

    expect{
      Srpm.remove_old(branch, path)
    }.to change{ Srpm.count }.from(2).to(1)

    $redis.get("#{branch.name}:openbox-3.4.11.1-alt1.1.1.src.rpm").should == '1'
    $redis.get("#{branch.name}:blackbox-1.0-alt1.src.rpm").should be_nil
    $redis.get("#{branch.name}:#{srpm2.name}:acls").should be_nil
    $redis.get("#{branch.name}:#{srpm2.name}:leader").should be_nil

    # TODO: add checks for sub packages, set-get-delete
  end

  it 'should increment counter after srpm import' do
    branch = FactoryGirl.create(:branch)
    branch.counter.value.should == 0
    group = FactoryGirl.create(:group, branch_id: branch.id)
    srpm = FactoryGirl.create(:srpm, branch_id: branch.id, group_id: group.id)
    branch.counter.value.should == 1
  end

  it 'should decrement counter after srpm delete' do
    branch = FactoryGirl.create(:branch)
    group = FactoryGirl.create(:group, branch_id: branch.id)
    srpm = FactoryGirl.create(:srpm, branch_id: branch.id, group_id: group.id)
    branch.counter.value.should == 1
    srpm.destroy
    branch.counter.value.should == 0
  end

  it 'should recount srpms in branch' do
    branch = FactoryGirl.create(:branch)
    branch.counter.value.should == 0
    group = FactoryGirl.create(:group, branch_id: branch.id)
    srpm = FactoryGirl.create(:srpm, branch_id: branch.id, group_id: group.id)
    branch.counter.value.should == 1
    Redis.current.set("branch:#{Branch.first.id}:counter", 0)
    branch.counter.value.should == 0
    branch.recount!
    branch.counter.value.should == 1
  end

  it 'should return acls array' do
    branch = FactoryGirl.create(:branch)
    group = FactoryGirl.create(:group, branch_id: branch.id)
    srpm = FactoryGirl.create(:srpm, branch_id: branch.id, group_id: group.id)
    srpm.acls << 'icesik' << '@everybody'
    srpm.maintainers.should == ['icesik']
    srpm.teams.should == ['@everybody']
  end

  it 'should return leader login' do
    branch = FactoryGirl.create(:branch)
    group = FactoryGirl.create(:group, branch_id: branch.id)
    srpm = FactoryGirl.create(:srpm, branch_id: branch.id, group_id: group.id)
    srpm.leader.should be_nil
    srpm.leader = 'icesik'
    srpm.reload
    srpm.leader.should == 'icesik'
  end

  it 'should return nil if leader is empty' do
    branch = FactoryGirl.create(:branch)
    group = FactoryGirl.create(:group, branch_id: branch.id)
    srpm = FactoryGirl.create(:srpm, branch_id: branch.id, group_id: group.id)
    srpm.leader = nil
    srpm.leader_is_team?.should be_nil
  end

  it 'should return true if leader is team' do
    branch = FactoryGirl.create(:branch)
    group = FactoryGirl.create(:group, branch_id: branch.id)
    srpm = FactoryGirl.create(:srpm, branch_id: branch.id, group_id: group.id)
    srpm.leader = '@everybody'
    srpm.leader_is_team?.should be_true
  end

  it 'should return false if leader is maintainer' do
    branch = FactoryGirl.create(:branch)
    group = FactoryGirl.create(:group, branch_id: branch.id)
    srpm = FactoryGirl.create(:srpm, branch_id: branch.id, group_id: group.id)
    srpm.leader = 'icesik'
    srpm.leader_is_team?.should be_false
  end
end
