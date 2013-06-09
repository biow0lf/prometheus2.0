require 'spec_helper'

describe Package do
  describe 'Associations' do
    it { should belong_to :branch }
    it { should belong_to :srpm }
    it { should belong_to :group }

    it { should have_many :provides }
    it { should have_many :requires }
    it { should have_many :obsoletes }
    it { should have_many :conflicts }
  end

  describe 'Validation' do
    it { should validate_presence_of :srpm }
    it { should validate_presence_of :branch }
    it { should validate_presence_of :group }
    it { should validate_presence_of :groupname }
    it { should validate_presence_of :md5 }
  end

  it { should have_db_index :arch }
  it { should have_db_index :branch_id }
  it { should have_db_index :group_id }
  it { should have_db_index :sourcepackage }
  it { should have_db_index :srpm_id }

  it 'should import package to database' do
    branch = FactoryGirl.create(:branch)
    group = FactoryGirl.create(:group, branch_id: branch.id)
    srpm = FactoryGirl.create(:srpm, branch_id: branch.id, group_id: group.id)

    file = 'openbox-3.5.0-alt1.i586.rpm'
    md5 = 'fd0100efb65fa82af3028e356a6f6304'

    rpm = mock
    Rpm.stub!(:new).and_return(rpm)
    rpm.should_receive(:sourcerpm).and_return('openbox-3.4.11.1-alt1.1.1.src.rpm')
    rpm.should_receive(:name).and_return('openbox')
    rpm.should_receive(:version).and_return('3.4.11.1')
    rpm.should_receive(:release).and_return('alt1.1.1')
    rpm.should_receive(:epoch).and_return(nil)
    rpm.should_receive(:arch).and_return('i586')
    rpm.should_receive(:group).and_return('Graphical desktop/Other')
    rpm.should_receive(:summary).and_return('short description')
    rpm.should_receive(:license).and_return('GPLv2+')
    rpm.should_receive(:url).and_return('http://openbox.org/')
    rpm.should_receive(:description).and_return('long description')
    rpm.should_receive(:buildtime).and_return(Time.at(1315301838))
    rpm.should_receive(:size).and_return(236554)
    rpm.should_receive(:md5).and_return(md5)

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
    package.groupname.should == 'Graphical desktop/Other'
    package.license.should == 'GPLv2+'
    package.url.should == 'http://openbox.org/'
    package.description.should == 'long description'
    package.buildtime.should == Time.at(1315301838)
    package.filename.should == 'openbox-3.5.0-alt1.i586.rpm'
    package.size.should == '236554'
    package.md5.should == 'fd0100efb65fa82af3028e356a6f6304'

    $redis.get("#{branch.name}:#{package.filename}").should == "1"
  end

  it 'should import all packages from path' do
    branch = FactoryGirl.create(:branch)
    pathes = ['/ALT/Sisyphus/files/i586/RPMS/*.i586.rpm']
    $redis.get("#{branch.name}:gcc-1.0-alt1.i586.rpm").should be_nil
    Dir.should_receive(:glob).and_return(['gcc-1.0-alt1.i586.rpm'])
    File.should_receive(:exist?).with('gcc-1.0-alt1.i586.rpm').and_return(true)
    Rpm.should_receive(:check_md5).and_return(true)
    Package.should_receive(:import).and_return(true)
    Package.import_all(branch, pathes)
  end
end
