require 'rails_helper'

describe RemoveOldSrpms do
  describe '#initialize' do
    let(:branch) { stub_model Branch }

    let(:path) { '/Sisyphus/' }

    subject { described_class.new(branch, path) }

    its(:branch) { should eq(branch) }

    its(:path) { should eq(path) }
  end

  describe '#perform' do
    let(:branch) { stub_model Branch }

    let(:srpm) do
      stub_model Srpm,
                 filename: 'openbox-1.0-alt1.src.rpm'
    end

    let(:path) { '/Sisyphus/' }

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

      before do
        expect(srpm).not_to receive(:destroy)
      end

      specify { expect { subject.perform }.not_to raise_error }
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

      specify { expect { subject.perform }.not_to raise_error }
    end
  end
end
