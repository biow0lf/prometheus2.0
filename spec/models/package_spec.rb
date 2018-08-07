# frozen_string_literal: true

require 'rails_helper'

describe Package do
  it { should be_a(ApplicationRecord) }

  let(:branch) { create(:branch, :with_paths) }
  let(:srcfilename) { 'openbox-3.4.11.1-alt1.1.1.src.rpm' }
  let(:group) { create(:group, branch: branch) }
  let(:named_srpm) { create(:named_srpm, branch: branch, group: group, name: srcfilename) }
  let(:srpm) { named_srpm.srpm }
  let(:branch_path) { branch.branch_paths.source.first }
  let(:package) { Package.first }

  describe 'Associations' do
    it { should belong_to(:srpm) }

    it { should belong_to(:group) }

    it { should have_many(:provides).dependent(:destroy) }

    it { should have_many(:requires).dependent(:destroy) }

    it { should have_many(:obsoletes).dependent(:destroy) }

    it { should have_many(:conflicts).dependent(:destroy) }
  end

  describe 'Validation' do
    it { should validate_presence_of(:groupname) }

    it { should validate_presence_of(:md5) }
  end

  describe 'Callbacks' do
    it { should callback(:add_filename_to_cache).after(:create) }

    it { should callback(:remove_filename_from_cache).after(:destroy) }
  end

  it 'should import package to database' do
    srpm
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

    expect { Package.import(branch_path, rpm) }.to change(Package, :count).by(1)

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
  end

  it 'should import all packages from path' do
    # TODO: add path to branch and branch factory
    branch = create(:branch, name: 'Sisyphus', vendor: 'ALT Linux')
    _branch_path = create(:branch_path, arch: "i586", path: '/ALT/Sisyphus/files/i586/RPMS/', branch: branch)
    expect(Redis.current.get("#{ branch.name }:gcc-1.0-alt1.i586.rpm")).to be_nil
    expect(Dir).to receive(:glob).and_return(['gcc-1.0-alt1.i586.rpm'])
    expect(File).to receive(:exist?).with('gcc-1.0-alt1.i586.rpm').and_return(true)
    expect(RPMCheckMD5).to receive(:check_md5).and_return(true)
    expect(Package).to receive(:import).and_return(true)
    Package.import_all(branch)
  end

  # private methods

  describe '#add_filename_to_cache' do
    subject { create :package, filename: 'openbox-1.0.i588.rpm' }

    specify { expect { subject.send(:add_filename_to_cache) }.not_to raise_error }
  end

  describe '#remove_filename_from_cache' do
    subject { create :package, filename: 'openbox-1.0.i588.rpm' }

    specify { expect { subject.send(:remove_filename_from_cache) }.not_to raise_error }
  end
end
