require 'spec_helper'
require 'rpmfile'

describe 'RPMFile::Binary' do
  it 'should return #arch' do
    file = 'spec/data/catpkt-1.0-alt5.i586.rpm'
    arch = 'i586'
    rpm = RPMFile::Binary.new(file)
    expect(rpm).to receive(:read_tag).with('ARCH').and_return(arch)
    expect(rpm.arch).to eq(arch)
  end

  it 'should return #filename' do
    file = 'spec/data/catpkt-1.0-alt5.i586.rpm'
    rpm = RPMFile::Binary.new(file)
    expect(rpm).to receive(:name).and_return('catpkt')
    expect(rpm).to receive(:version).and_return('1.0')
    expect(rpm).to receive(:release).and_return('alt5')
    expect(rpm).to receive(:arch).and_return('i586')
    expect(rpm.filename).to eq('catpkt-1.0-alt5.i586.rpm')
  end

  it 'should return #sourcerpm' do
    file = 'spec/data/catpkt-1.0-alt5.i586.rpm'
    sourcerpm = 'catpkt-1.0-alt5.src.rpm'
    rpm = RPMFile::Binary.new(file)
    expect(rpm).to receive(:read_tag).with('SOURCERPM').and_return(sourcerpm)
    expect(rpm.sourcerpm).to eq(sourcerpm)
  end
end
