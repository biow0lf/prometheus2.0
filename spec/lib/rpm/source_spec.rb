require 'rails_helper'

describe RPM::Source do
  let(:file) { 'spec/data/catpkt-1.0-alt5.src.rpm' }

  subject { described_class.new(file) }

  describe '#filename' do
    specify { expect(subject.filename).to eq('catpkt-1.0-alt5.src.rpm') }
  end
end
