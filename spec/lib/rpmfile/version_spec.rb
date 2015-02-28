require 'spec_helper'
require 'rpmfile'

describe 'RPMFile::VERSION' do
  it 'should expose RPMFile::Version' do
    expect(RPMFile::VERSION).to eq('0.0.1')
  end
end
