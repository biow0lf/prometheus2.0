require 'spec_helper'
require 'rpmfile'

describe 'RPMFile::Base' do
  pending 'read_raw'

  it 'should read any tag via #read_tag' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    name = 'catpkt'
    rpm = RPMFile::Base.new(file)
    expect(rpm).to receive(:read_raw).with('%{NAME}').and_return(name)
    expect(rpm.read_tag('NAME')).to eq(name)
  end

  it 'should return #name' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    name = 'catpkt'
    rpm = RPMFile::Base.new(file)
    expect(rpm).to receive(:read_tag).with('NAME').and_return(name)
    expect(rpm.name).to eq(name)
  end

  it 'should return #version' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    version = '1.0'
    rpm = RPMFile::Base.new(file)
    expect(rpm).to receive(:read_tag).with('VERSION').and_return(version)
    expect(rpm.version).to eq(version)
  end

  it 'should return #release' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    release = 'alt5'
    rpm = RPMFile::Base.new(file)
    expect(rpm).to receive(:read_tag).with('RELEASE').and_return(release)
    expect(rpm.release).to eq(release)
  end

  it 'should return #epoch' do
    file = 'spec/data/xmms-1.2.11-alt11.src.rpm'
    rpm = RPMFile::Base.new(file)
    expect(rpm).to receive(:read_tag).with('EPOCH').and_return('20131206')
    expect(rpm.epoch).to eq('20131206')
  end

  it 'should return #summary' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    summary = 'FTS Packet Viewer'
    rpm = RPMFile::Base.new(file)
    expect(rpm).to receive(:read_tag).with('SUMMARY').and_return(summary)
    expect(rpm.summary).to eq(summary)
  end

  it 'should return #group' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    group = 'Text tools'
    rpm = RPMFile::Base.new(file)
    expect(rpm).to receive(:read_tag).with('GROUP').and_return(group)
    expect(rpm.group).to eq(group)
  end

  it 'should return #license' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    license = 'BSD-like'
    rpm = RPMFile::Base.new(file)
    expect(rpm).to receive(:read_tag).with('LICENSE').and_return(license)
    expect(rpm.license).to eq(license)
  end

  it 'should return #url' do
    file = 'spec/data/xmms-1.2.11-alt11.src.rpm'
    url = 'http://xmms.org'
    rpm = RPMFile::Base.new(file)
    expect(rpm).to receive(:read_tag).with('URL').and_return(url)
    expect(rpm.url).to eq(url)
  end

  it 'should return #packager' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    packager = 'Igor Zubkov <icesik@altlinux.org>'
    rpm = RPMFile::Base.new(file)
    expect(rpm).to receive(:read_tag).with('PACKAGER').and_return(packager)
    expect(rpm.packager).to eq(packager)
  end

  it 'should return #vendor' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    vendor = 'ALT Linux Team'
    rpm = RPMFile::Base.new(file)
    expect(rpm).to receive(:read_tag).with('VENDOR').and_return(vendor)
    expect(rpm.vendor).to eq(vendor)
  end

  it 'should return #distribution' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    distribution = 'ALT Linux'
    rpm = RPMFile::Base.new(file)
    expect(rpm).to receive(:read_tag).with('DISTRIBUTION').and_return(distribution)
    expect(rpm.distribution).to eq(distribution)
  end

  it 'should return #description' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    text = 'Viewer for out/in-bound ftn-packets.'
    rpm = RPMFile::Base.new(file)
    expect(rpm).to receive(:read_tag).with('DESCRIPTION').and_return("#{ text }...")
    expect(rpm.description).to start_with(text)
  end

  it 'should return #buildhost' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    buildhost = 'icesik.hasher.altlinux.org'
    rpm = RPMFile::Base.new(file)
    expect(rpm).to receive(:read_tag).with('BUILDHOST').and_return(buildhost)
    expect(rpm.buildhost).to eq(buildhost)
  end

  it 'should return #buildtime' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    buildtime = '1349449185'
    rpm = RPMFile::Base.new(file)
    expect(rpm).to receive(:read_tag).with('BUILDTIME').and_return(buildtime)
    expect(rpm.buildtime).to eq(Time.at(buildtime.to_i))
    expect(rpm.buildtime).to be_an_instance_of(Time)
  end

  it 'should return #changelogname' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    changelogname = 'Igor Zubkov <icesik@altlinux.org> 1.0-alt5'
    rpm = RPMFile::Base.new(file)
    expect(rpm).to receive(:read_tag).with('CHANGELOGNAME').and_return(changelogname)
    expect(rpm.changelogname).to eq(changelogname)
  end

  it 'should return #changelogtext' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    changelogtext = '- rebuilt for debuginfo'
    rpm = RPMFile::Base.new(file)
    expect(rpm).to receive(:read_tag).with('CHANGELOGTEXT').and_return(changelogtext)
    expect(rpm.changelogtext).to eq(changelogtext)
  end

  it 'should return #changelogtime' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    changelogtime = '1349438400'
    rpm = RPMFile::Base.new(file)
    expect(rpm).to receive(:read_tag).with('CHANGELOGTIME').and_return(changelogtime)
    expect(rpm.changelogtime).to eq(changelogtime)
  end

  it 'should raise exception on #filename' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    rpm = RPMFile::Base.new(file)
    expect { rpm.filename }.to raise_exception(NotImplementedError)
  end

  it 'should return #md5' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    rpm = RPMFile::Base.new(file)
    expect(rpm).to receive(:`).with("md5sum #{ file }").and_return("35f0f45bfbcdaf8754713fc1c97f8068  spec/data/catpkt-1.0-alt5.src.rpm\n")
    expect(rpm.md5).to eq('35f0f45bfbcdaf8754713fc1c97f8068')
  end

  it 'should return #size' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    rpm = RPMFile::Base.new(file)
    expect(File).to receive(:size).with(file).and_return(14_216)
    expect(rpm.size).to eq('14216')
  end
end
