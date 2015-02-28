require 'spec_helper'
require 'rpmfile'

describe RPMFile::Base do
  pending 'read_raw'
  pending 'read_tag'

  it 'should return #name' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    expect(RPMFile::Base.new(file).name).to eq('catpkt')
  end

  it 'should return #version' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    expect(RPMFile::Base.new(file).version).to eq('1.0')
  end

  it 'should return #release' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    expect(RPMFile::Base.new(file).release).to eq('alt5')
  end

  it 'should return #epoch' do
    file = 'spec/data/xmms-1.2.11-alt11.src.rpm'
    expect(RPMFile::Base.new(file).epoch).to eq('20131206')
  end

  it 'should return #summary' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    expect(RPMFile::Base.new(file).summary).to eq('FTS Packet Viewer')
  end

  it 'should return #group' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    expect(RPMFile::Base.new(file).group).to eq('Text tools')
  end

  it 'should return #license' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    expect(RPMFile::Base.new(file).license).to eq('BSD-like')
  end

  it 'should return #url' do
    file = 'spec/data/xmms-1.2.11-alt11.src.rpm'
    expect(RPMFile::Base.new(file).url).to eq('http://xmms.org')
  end

  it 'should return #packager' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    expect(RPMFile::Base.new(file).packager).to eq('Igor Zubkov <icesik@altlinux.org>')
  end

  it 'should return #vendor' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    expect(RPMFile::Base.new(file).vendor).to eq('ALT Linux Team')
  end

  it 'should return #distribution' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    expect(RPMFile::Base.new(file).distribution).to eq('ALT Linux')
  end

  pending 'DESCRIPTION'

  it 'should return #buildhost' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    expect(RPMFile::Base.new(file).buildhost).to eq('icesik.hasher.altlinux.org')
  end

  pending '#buildtime'

  it 'should return #changelogname' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    expect(RPMFile::Base.new(file).changelogname).to eq('Igor Zubkov <icesik@altlinux.org> 1.0-alt5')
  end

  it 'should return #changelogtext' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    expect(RPMFile::Base.new(file).changelogtext).to eq('- rebuilt for debuginfo')
  end

  pending 'should return #changelogtime' do
    file = 'spec/data/catpkt-1.0-alt5.src.rpm'
    expect(RPMFile::Base.new(file).changelogtime).to eq('FTS Packet Viewer')
  end

  pending '#filename'

  pending '#md5'

  pending '#size'
end
