require 'rails_helper'

describe RemoveOldSrpms do
  let(:branch) { double }

  let(:path) { '/Sisyphus/' }

  subject { described_class.new(branch, path) }

  it { should be_a(Rectify::Command) }

  describe '#initialize' do
    its(:branch) { should eq(branch) }

    its(:path) { should eq(path) }
  end

  describe '#call' do
    let(:srpm) { stub_model Srpm, filename: 'openbox-1.0-alt1.src.rpm' }

    subject { described_class.new(branch, path) }

    before { expect(branch).to receive(:srpms).and_return([srpm]) }

    context 'srpm file exists' do
      before do
        #
        # File.exist?("#{ path }#{ srpm.filename }")
        #
        expect(File).to receive(:exist?)
          .with('/Sisyphus/openbox-1.0-alt1.src.rpm')
          .and_return(true)
      end

      before { expect(srpm).not_to receive(:destroy) }

      before { expect(subject).to receive(:broadcast).with(:ok) }

      specify { expect { subject.call }.not_to raise_error }
    end

    context 'srpm file not exists' do
      before do
        #
        # File.exist?("#{ path }#{ srpm.filename }")
        #
        expect(File).to receive(:exist?)
          .with('/Sisyphus/openbox-1.0-alt1.src.rpm')
          .and_return(false)
      end

      before { expect(srpm).to receive(:destroy) }

      before { expect(subject).to receive(:broadcast).with(:ok) }

      specify { expect { subject.call }.not_to raise_error }
    end
  end
end
