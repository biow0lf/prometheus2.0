# frozen_string_literal: true

require 'rails_helper'

describe RPM::Binary do
  let(:file) { 'spec/data/catpkt-1.0-alt5.x86_64.rpm' }

  subject { described_class.new(file) }

  describe '#filename' do
    context '@filename not set' do
      specify { expect(subject.filename).to eq('catpkt-1.0-alt5.x86_64.rpm') }

      specify { expect { subject.filename }.to change { subject.instance_variable_get(:@filename) }.from(nil).to('catpkt-1.0-alt5.x86_64.rpm') }
    end

    context '@filename is set' do
      let(:filename) { double }

      before { subject.instance_variable_set(:@filename, filename) }

      specify { expect(subject.filename).to eq(filename) }
    end
  end

  describe '#arch' do
    context '@arch not set' do
      specify { expect(subject.arch).to eq('x86_64') }

      specify { expect { subject.arch }.to change { subject.instance_variable_get(:@arch) }.from(nil).to('x86_64') }
    end

    context '@arch is set' do
      let(:arch) { double }

      before { subject.instance_variable_set(:@arch, arch) }

      specify { expect(subject.arch).to eq(arch) }
    end
  end

  describe '#sourcerpm' do
    context '@sourcerpm not set' do
      specify { expect(subject.sourcerpm).to eq('catpkt-1.0-alt5.src.rpm') }

      specify { expect { subject.sourcerpm }.to change { subject.instance_variable_get(:@sourcerpm) }.from(nil).to('catpkt-1.0-alt5.src.rpm') }
    end

    context '@sourcerpm is set' do
      let(:sourcerpm) { double }

      before { subject.instance_variable_set(:@sourcerpm, sourcerpm) }

      specify { expect(subject.sourcerpm).to eq(sourcerpm) }
    end
  end
end
