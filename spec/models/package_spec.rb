require 'rails_helper'

describe Package do
  context 'Associations' do
    it { should belong_to :branch }
    it { should belong_to :srpm }
    it { should belong_to :group }

    it { should have_many :provides }
    it { should have_many :requires }
    it { should have_many :obsoletes }
    it { should have_many :conflicts }
  end

  context 'Validation' do
    it { should validate_presence_of :srpm }
    it { should validate_presence_of :branch }
    it { should validate_presence_of :group }
    it { should validate_presence_of :groupname }
    it { should validate_presence_of :md5 }
  end

  context 'DB Indexes' do
    it { should have_db_index :arch }
    it { should have_db_index :branch_id }
    it { should have_db_index :group_id }
    it { should have_db_index :name }
    it { should have_db_index :sourcepackage }
    it { should have_db_index :srpm_id }
  end

  it 'should import package to database' do
    branch = FactoryGirl.create(:branch)
    group = FactoryGirl.create(:group, branch_id: branch.id)
    FactoryGirl.create(:srpm, branch_id: branch.id, group_id: group.id)

    file = 'openbox-3.5.0-alt1.i586.rpm'

    md5 = "fd0100efb65fa82af3028e356a6f6304  /ALT/Sisyphus/files/i586/RPMS/#{ file }"
    expect(Package).to receive(:`).with("/usr/bin/md5sum #{ file }").and_return(md5)

    expect(Package).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{SOURCERPM}' #{ file }").and_return('openbox-3.4.11.1-alt1.1.1.src.rpm')
    expect(Package).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{NAME}' #{ file }").and_return('openbox')
    expect(Package).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{VERSION}' #{ file }").and_return('3.4.11.1')
    expect(Package).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{RELEASE}' #{ file }").and_return('alt1.1.1')
    expect(Package).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{EPOCH}' #{ file }").and_return('(none)')
    expect(Package).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{ARCH}' #{ file }").and_return('i586')
    expect(Package).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{GROUP}' #{file}").and_return('Graphical desktop/Other')
    expect(Package).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{SUMMARY}' #{ file }").and_return('short description')
    expect(Package).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{LICENSE}' #{ file }").and_return('GPLv2+')
    expect(Package).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{URL}' #{ file }").and_return('http://openbox.org/')
    expect(Package).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{DESCRIPTION}' #{ file }").and_return('long description')
    expect(Package).to receive(:`).with("export LANG=C && rpm -qp --queryformat='%{BUILDTIME}' #{ file }").and_return('1315301838')

    expect(File).to receive(:size).with(file).and_return(236_554)

    expect {
      Package.import(branch, file)
    }.to change(Package, :count).by(1)

    package = Package.first
    expect(package.name).to eq('openbox')
    expect(package.version).to eq('3.4.11.1')
    expect(package.release).to eq('alt1.1.1')
    expect(package.epoch).to be_nil
    expect(package.summary).to eq('short description')
    expect(package.group.full_name).to eq('Graphical desktop/Other')
    expect(package.groupname).to eq('Graphical desktop/Other')
    expect(package.license).to eq('GPLv2+')
    expect(package.url).to eq('http://openbox.org/')
    expect(package.description).to eq('long description')
    # FIXME:
    # package.buildtime.should == Time.at(1315301838)
    expect(package.filename).to eq('openbox-3.5.0-alt1.i586.rpm')

    expect(Redis.current.get("#{branch.name}:#{package.filename}")).to eq('1')
  end

  it 'should import all packages from path' do
    branch = FactoryGirl.create(:branch)
    pathes = ['/ALT/Sisyphus/files/i586/RPMS/*.i586.rpm']
    expect(Redis.current.get("#{branch.name}:gcc-1.0-alt1.i586.rpm")).to be_nil
    expect(Dir).to receive(:glob).and_return(['gcc-1.0-alt1.i586.rpm'])
    expect(File).to receive(:exist?).with('gcc-1.0-alt1.i586.rpm').and_return(true)
    expect(RPM).to receive(:check_md5).and_return(true)
    expect(Package).to receive(:import).and_return(true)
    Package.import_all(branch, pathes)
  end
end
