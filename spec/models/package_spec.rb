require 'rails_helper'

describe Package do
  context 'Associations' do
    it { is_expected.to belong_to :branch }
    it { is_expected.to belong_to :srpm }
    it { is_expected.to belong_to :group }

    it { is_expected.to have_many :provides }
    it { is_expected.to have_many :requires }
    it { is_expected.to have_many :obsoletes }
    it { is_expected.to have_many :conflicts }
  end

  context 'Validation' do
    it { is_expected.to validate_presence_of :srpm }
    it { is_expected.to validate_presence_of :branch }
    it { is_expected.to validate_presence_of :group }
    it { is_expected.to validate_presence_of :groupname }
    it { is_expected.to validate_presence_of :md5 }
  end

  context 'DB Indexes' do
    it { is_expected.to have_db_index :arch }
    it { is_expected.to have_db_index :branch_id }
    it { is_expected.to have_db_index :group_id }
    it { is_expected.to have_db_index :name }
    it { is_expected.to have_db_index :sourcepackage }
    it { is_expected.to have_db_index :srpm_id }
  end

  it 'should import package to database' do
    branch = create(:branch, name: 'Sisyphus', vendor: 'ALT Linux')
    group = create(:group, branch_id: branch.id)
    create(:srpm, branch_id: branch.id, group_id: group.id)
    file = 'openbox-3.4.11.1-alt1.1.1.i586.rpm'
    md5 = 'fd0100efb65fa82af3028e356a6f6304'
    rpm = RPMFile::Binary.new(file)

    expect(rpm).to receive(:name).and_return('openbox')
    expect(rpm).to receive(:version).and_return('3.4.11.1')
    expect(rpm).to receive(:release).and_return('alt1.1.1')
    expect(rpm).to receive(:epoch).and_return(nil)
    expect(rpm).to receive(:summary).and_return('short description')
    expect(rpm).to receive(:group).and_return('Graphical desktop/Other')
    expect(rpm).to receive(:license).and_return('GPLv2+')
    expect(rpm).to receive(:url).and_return('http://openbox.org/')
    # expect(rpm).to receive(:packager)
    # expect(rpm).to receive(:vendor)
    # expect(rpm).to receive(:distribution)
    expect(rpm).to receive(:description).and_return('long description')
    # expect(rpm).to receive(:buildhost)
    expect(rpm).to receive(:buildtime).and_return(Time.at('1315301838'.to_i))
    # expect(rpm).to receive(:changelogname)
    # expect(rpm).to receive(:changelogtext)
    # expect(rpm).to receive(:changelogtime)
    expect(rpm).to receive(:md5).and_return(md5)
    expect(rpm).to receive(:size).and_return(236_554)
    expect(rpm).to receive(:arch).and_return('i586')
    expect(rpm).to receive(:filename).and_return(file)
    expect(rpm).to receive(:sourcerpm).and_return('openbox-3.4.11.1-alt1.1.1.src.rpm')

    expect { Package.import(branch, rpm) }.to change(Package, :count).by(1)

    package = Package.first
    expect(package.name).to eq('openbox')
    expect(package.version).to eq('3.4.11.1')
    expect(package.release).to eq('alt1.1.1')
    expect(package.epoch).to be_nil
    expect(package.summary).to eq('short description')
    # expect(package.group.full_name).to eq('Graphical desktop/Other')
    expect(package.groupname).to eq('Graphical desktop/Other')
    expect(package.license).to eq('GPLv2+')
    expect(package.url).to eq('http://openbox.org/')
    # expect(package.packager).to eq('')
    # expect(package.vendor).to eq('')
    # expect(package.distribution).to eq('')
    expect(package.description).to eq('long description')
    # expect(package.buildhost).to eq('')
    # expect(package.buildtime).to eq(Time.at('1315301838'.to_i))
    # expect(package.changelogname).to eq('')
    # expect(package.changelogtext).to eq('')
    # expect(package.changelogtime).to eq('')
    expect(package.md5).to eq(md5)
    expect(package.size).to eq(236_554)
    expect(package.arch).to eq('i586')
    expect(package.filename).to eq(file)
    expect(package.sourcepackage).to eq('openbox-3.4.11.1-alt1.1.1.src.rpm')

    expect(Redis.current.get("#{branch.name}:#{package.filename}")).to eq('1')
  end

  it 'should import all packages from path' do
    branch = create(:branch, name: 'Sisyphus', vendor: 'ALT Linux')
    pathes = ['/ALT/Sisyphus/files/i586/RPMS/*.i586.rpm']
    expect(Redis.current.get("#{branch.name}:gcc-1.0-alt1.i586.rpm")).to be_nil
    expect(Dir).to receive(:glob).and_return(['gcc-1.0-alt1.i586.rpm'])
    expect(File).to receive(:exist?).with('gcc-1.0-alt1.i586.rpm').and_return(true)
    expect(RPM).to receive(:check_md5).and_return(true)
    expect(Package).to receive(:import).and_return(true)
    Package.import_all(branch, pathes)
  end
end
