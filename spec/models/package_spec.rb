# encoding: utf-8

require 'spec_helper'

describe Package do
  it { should belong_to :branch }
  it { should belong_to :srpm }
  it { should belong_to :group }

  it { should validate_presence_of :srpm }
  it { should validate_presence_of :branch }
  it { should validate_presence_of :group }
  it { should validate_presence_of :md5 }

  it { should have_db_index :arch }
  it { should have_db_index :branch_id }
  it { should have_db_index :group_id }
  it { should have_db_index :sourcepackage }
  it { should have_db_index :srpm_id }

  it { should have_many :provides }
  it { should have_many :requires }
  it { should have_many :obsoletes }
  it { should have_many :conflicts }

  it "should import package to database" do
    branch = FactoryGirl.create(:branch)
    group = FactoryGirl.create(:group, branch_id: branch.id)
    srpm = FactoryGirl.create(:srpm, branch_id: branch.id, group_id: group.id)

    file = 'openbox-3.5.0-alt1.i586.rpm'

    md5 = "fd0100efb65fa82af3028e356a6f6304  /ALT/Sisyphus/files/i586/RPMS/#{file}"
    Package.should_receive(:`).with("/usr/bin/md5sum #{file}").and_return(md5)

    Package.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{SOURCERPM}' #{file}").and_return('openbox-3.4.11.1-alt1.1.1.src.rpm')
    Package.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{NAME}' #{file}").and_return('openbox')
    Package.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{VERSION}' #{file}").and_return('3.4.11.1')
    Package.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{RELEASE}' #{file}").and_return('alt1.1.1')
    Package.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{EPOCH}' #{file}").and_return('(none)')
    Package.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{ARCH}' #{file}").and_return('i586')
    Package.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{GROUP}' #{file}").and_return('Graphical desktop/Other')
    Package.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{SUMMARY}' #{file}").and_return('short description')
    Package.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{LICENSE}' #{file}").and_return('GPLv2+')
    Package.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{URL}' #{file}").and_return('http://openbox.org/')
    Package.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{DESCRIPTION}' #{file}").and_return('long description')
    Package.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{BUILDTIME}' #{file}").and_return('1315301838')

    File.should_receive(:size).with(file).and_return(236554)

    expect{
      Package.import(branch, file)
      }.to change{ Package.count }.from(0).to(1)

    package = Package.first
    package.name.should == 'openbox'
    package.version.should == '3.4.11.1'
    package.release.should == 'alt1.1.1'
    package.epoch.should be_nil
    package.summary.should == 'short description'
    package.group.full_name.should == 'Graphical desktop/Other'
    package.license.should == 'GPLv2+'
    package.url.should == 'http://openbox.org/'
    package.description.should == 'long description'
    # FIXME:
    # package.buildtime.should == Time.at(1315301838)
    package.filename.should == 'openbox-3.5.0-alt1.i586.rpm'

    $redis.get("#{branch.name}:#{package.filename}").should == "1"
  end

  it "should import all packages from path" do
    branch = FactoryGirl.create(:branch)
    pathes = ['/ALT/Sisyphus/files/i586/RPMS/*.i586.rpm']
    $redis.get("#{branch.name}:gcc-1.0-alt1.i586.rpm").should be_nil
    Dir.should_receive(:glob).and_return(['gcc-1.0-alt1.i586.rpm'])
    File.should_receive(:exist?).with('gcc-1.0-alt1.i586.rpm').and_return(true)
    RPM.should_receive(:check_md5).and_return(true)
    Package.should_receive(:import).and_return(true)
    Package.import_all(branch, pathes)
  end
end
