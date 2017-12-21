# frozen_string_literal: true

require 'rails_helper'

describe RPM::Source do
  let(:file) { 'spec/data/catpkt-1.0-alt5.src.rpm' }

  subject { described_class.new(file) }

  describe '#filename' do
    context '@filename not set' do
      specify { expect(subject.filename).to eq('catpkt-1.0-alt5.src.rpm') }

      specify { expect { subject.filename }.to change { subject.instance_variable_get(:@filename) }.from(nil).to('catpkt-1.0-alt5.src.rpm') }
    end

    context '@filename is set' do
      let(:filename) { double }

      before { subject.instance_variable_set(:@filename, filename) }

      specify { expect(subject.filename).to eq(filename) }
    end
  end
end
