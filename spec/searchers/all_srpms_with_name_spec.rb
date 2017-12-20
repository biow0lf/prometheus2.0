# frozen_string_literal: true

require 'rails_helper'

describe AllSrpmsWithName do
  subject { described_class.new(name) }

  describe '#initialize' do
    let(:name) { double }

    its(:name) { should eq(name) }
  end

  describe '#search' do
    let(:name) { 'glibc' }

    let!(:srpm1) { create(:srpm, name: 'glibc') }

    let!(:srpm2) { create(:srpm, name: 'glibc') }

    let!(:srpm3) { create(:srpm, name: 'glibc') }

    specify { expect(subject.search).to eq([srpm1, srpm2, srpm3]) }
  end
end
