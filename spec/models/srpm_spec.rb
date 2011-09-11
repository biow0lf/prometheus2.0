require 'spec_helper'

describe Srpm do
  it { should belong_to :branch }
  it { should belong_to :group }
  it { should have_many :packages }
  it { should have_many :changelogs }
  it { should have_one :leader }
  it { should have_one(:maintainer).through(:leader) }
  it { should have_many :acls }
  it { should have_many :repocops }
  it { should have_one :specfile }
  it { should have_one :repocop_patch }
  it { should have_many :patches }

  # pending "test :dependent => :destroy for :packages, :changelogs, :leaders, :acls"
  # pending "test :foreign_key => 'srcname', :primary_key => 'name' for :repocops"

  it { should validate_presence_of :branch }
  it { should validate_presence_of :group }
  it { should validate_presence_of :md5 }

  it { should have_db_index :branch_id }
  it { should have_db_index :group_id }
  it { should have_db_index :name }
  it { should have_db_index :specfile_id }

  it "should return Srpm.name on .to_param" do
    branch = FactoryGirl.create(:branch)
    group0 = Group.create!(:name => 'Graphical desktop', :branch_id => branch.id)
    group = Group.create!(:name => 'Other', :branch_id => branch.id)
    group.move_to_child_of(group0)

    Srpm.create!(:branch_id => branch.id,
                 :name => 'openbox',
                 :version => '3.4.11.1',
                 :release => 'alt1.1.1',
                 :summary => 'short description',
                 :description => 'long description',
                 :group_id => group.id,
                 :license => 'GPLv2+',
                 :url => 'http://openbox.org/',
                 :size => 831617,
                 :filename => 'openbox-3.4.11.1-alt1.1.1.src.rpm',
                 :md5 => 'f87ff0eaa4e16b202539738483cd54d1',
                 :buildtime => '2010-11-24 23:58:02 UTC').to_param.should == 'openbox'
  end

  it "should import srpm file" do
    branch = FactoryGirl.create(:branch)
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    md5 = "f87ff0eaa4e16b202539738483cd54d1  /Sisyphus/files/SRPMS/#{file}"
    Srpm.should_receive(:`).with("/usr/bin/md5sum #{file}").and_return(md5)
    Srpm.should_receive(:`).with("rpm -qp --queryformat='%{NAME}' #{file}").and_return('openbox')
    Srpm.should_receive(:`).with("rpm -qp --queryformat='%{VERSION}' #{file}").and_return('3.4.11.1')
    Srpm.should_receive(:`).with("rpm -qp --queryformat='%{RELEASE}' #{file}").and_return('alt1.1.1')
    Srpm.should_receive(:`).with("rpm -qp --queryformat='%{EPOCH}' #{file}").and_return('(none)')
    Srpm.should_receive(:`).with("rpm -qp --queryformat='%{SUMMARY}' #{file}").and_return('short description')
    Srpm.should_receive(:`).with("rpm -qp --queryformat='%{GROUP}' #{file}").and_return('Graphical desktop/Other')
    Srpm.should_receive(:`).with("rpm -qp --queryformat='%{LICENSE}' #{file}").and_return('GPLv2+')
    Srpm.should_receive(:`).with("rpm -qp --queryformat='%{URL}' #{file}").and_return('http://openbox.org/')
    Srpm.should_receive(:`).with("rpm -qp --queryformat='%{DESCRIPTION}' #{file}").and_return('long description')
    Srpm.should_receive(:`).with("rpm -qp --queryformat='%{VENDOR}' #{file}").and_return('ALT Linux Team')
    Srpm.should_receive(:`).with("rpm -qp --queryformat='%{DISTRIBUTION}' #{file}").and_return('ALT Linux')
    Srpm.should_receive(:`).with("rpm -qp --queryformat='%{BUILDTIME}' #{file}").and_return('1315301838')
    Srpm.should_receive(:`).with("rpm -qp --queryformat='%{CHANGELOGTIME}' #{file}").and_return('1312545600')
    Srpm.should_receive(:`).with("rpm -qp --queryformat='%{CHANGELOGNAME}' #{file}").and_return('Igor Zubkov <icesik@altlinux.org> 3.4.11.1-alt1.1.1')
    Srpm.should_receive(:`).with("rpm -qp --queryformat='%{CHANGELOGTEXT}' #{file}").and_return('- 3.4.11.1')

    File.should_receive(:size).with(file).and_return(831617)

    Specfile.should_receive(:import).and_return(true)
    Changelog.should_receive(:import).and_return(true)

    expect{
      Srpm.import(branch, file)
      }.to change{ Srpm.count }.from(0).to(1)

    srpm = Srpm.first
    srpm.name.should == 'openbox'
    srpm.version.should == '3.4.11.1'
    srpm.release.should == 'alt1.1.1'
    srpm.epoch.should be_nil
    srpm.summary.should == 'short description'
    srpm.group.full_name.should == 'Graphical desktop/Other'
    srpm.license.should == 'GPLv2+'
    srpm.url.should == 'http://openbox.org/'
    srpm.description.should == 'long description'
    srpm.vendor.should == 'ALT Linux Team'
    srpm.distribution.should == 'ALT Linux'
    # FIXME:
    # srpm.buildtime.should == Time.at(1315301838)
    # srpm.changelogtime.should == Time.at(1312545600)
    srpm.changelogname.should == 'Igor Zubkov <icesik@altlinux.org> 3.4.11.1-alt1.1.1'
    srpm.changelogtext.should == '- 3.4.11.1'
    srpm.filename.should == 'openbox-3.4.11.1-alt1.1.1.src.rpm'

    $redis.get("#{branch.name}:#{srpm.filename}").should == "1"
    $redis.get("#{branch.name}:srpms:counter").should == "1"
  end

  it "should import all srpms from path" do
    branch = FactoryGirl.create(:branch)
    path = '/ALT/Sisyphus/files/SRPMS/*.src.rpm'
    $redis.get("#{branch.name}:glibc-2.11.3-alt6.src.rpm").should be_nil
    Dir.should_receive(:glob).with(path).and_return(['glibc-2.11.3-alt6.src.rpm'])
    Srpm.should_receive(:import).and_return(true)
    RPM.should_receive(:check_md5).and_return(true)
    Srpm.import_all(branch, path)
  end

  it "should remove old srpms from database" do
    branch = FactoryGirl.create(:branch)
    $redis.set("#{branch.name}:srpms:counter", 0)
    group = FactoryGirl.create(:group, :branch_id => branch.id)
    srpm1 = FactoryGirl.create(:srpm, :branch_id => branch.id, :group_id => group.id)
    $redis.set("#{branch.name}:#{srpm1.filename}", 1)
    $redis.incr("#{branch.name}:srpms:counter")
    srpm2 = FactoryGirl.create(:srpm, :name => 'blackbox', :filename => 'blackbox-1.0-alt1.src.rpm', :branch_id => branch.id, :group_id => group.id)
    $redis.set("#{branch.name}:#{srpm2.filename}", 1)
    $redis.incr("#{branch.name}:srpms:counter")

    path = '/ALT/Sisyphus/files/SRPMS/'

    File.should_receive(:exists?).with("#{path}openbox-3.4.11.1-alt1.1.1.src.rpm").and_return(true)
    File.should_receive(:exists?).with("#{path}blackbox-1.0-alt1.src.rpm").and_return(false)

    expect{
      Srpm.remove_old(branch, path)
    }.to change{ Srpm.count }.from(2).to(1)

    $redis.get("#{branch.name}:openbox-3.4.11.1-alt1.1.1.src.rpm").should == '1'
    $redis.get("#{branch.name}:blackbox-1.0-alt1.src.rpm").should be_nil
    $redis.get("#{branch.name}:srpms:counter").should == '1'

    # TODO: add checks for sub packages, set-get-delete
  end
end
