require 'spec_helper'

describe 'RPMFile::Source' do
  it 'should return #filename' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    rpm = RPMFile::Source.new(file)
    expect(rpm).to receive(:name).and_return('catpkt')
    expect(rpm).to receive(:version).and_return('1.0')
    expect(rpm).to receive(:release).and_return('alt5')
    expect(rpm.filename).to eq('catpkt-1.0-alt5.src.rpm')
  end
end
