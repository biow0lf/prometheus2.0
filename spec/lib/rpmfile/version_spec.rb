require 'spec_helper'
require 'rpmfile'

describe 'RPMFile::VERSION' do
  it 'does expose version' do
    expect(RPMFile::VERSION).to eq('0.0.1')
  end
end
