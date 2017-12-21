# frozen_string_literal: true

require 'spec_helper'
require 'rpmfile'

describe RPMFile::Source do
  let(:file) { 'spec/data/catpkt-1.0-alt5.src.rpm' }
  let(:rpm) { RPMFile::Source.new(file) }

  context '#filename' do
    it 'does return filename' do
      expect(rpm).to receive(:name).and_return('catpkt')
      expect(rpm).to receive(:version).and_return('1.0')
      expect(rpm).to receive(:release).and_return('alt5')
      expect(rpm.filename).to eq('catpkt-1.0-alt5.src.rpm')
    end
  end
end
