# frozen_string_literal: true

require 'spec_helper'
require 'rpmfile'

describe RPMFile::Binary do
  let(:file) { 'spec/data/catpkt-1.0-alt5.i586.rpm' }
  let(:rpm) { RPMFile::Binary.new(file) }

  context '#arch' do
    it 'does return arch' do
      arch = 'i586'
      expect(rpm).to receive(:read_tag).with('ARCH').and_return(arch)
      expect(rpm.arch).to eq(arch)
    end
  end

  context '#filename' do
    it 'does return filename' do
      expect(rpm).to receive(:name).and_return('catpkt')
      expect(rpm).to receive(:version).and_return('1.0')
      expect(rpm).to receive(:release).and_return('alt5')
      expect(rpm).to receive(:arch).and_return('i586')
      expect(rpm.filename).to eq('catpkt-1.0-alt5.i586.rpm')
    end
  end

  context '#sourcerpm' do
    it 'does return source rpm' do
      sourcerpm = 'catpkt-1.0-alt5.src.rpm'
      expect(rpm).to receive(:read_tag).with('SOURCERPM').and_return(sourcerpm)
      expect(rpm.sourcerpm).to eq(sourcerpm)
    end
  end
end
