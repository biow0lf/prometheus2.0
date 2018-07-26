# frozen_string_literal: true

require 'rails_helper'

describe RemoveOldSrpms do
  let(:branch) { create(:branch) }

  let(:path) { '/Sisyphus/' }

  subject { described_class.new(branch, path) }

  it { should be_a(Rectify::Command) }

  describe '#initialize' do
    its(:branch) { should eq(branch) }

    its(:path) { should eq(path) }
  end

  describe '#call' do
    let!(:srpm) { create(:srpm, filename: 'openbox-1.0-alt1.src.rpm', branch: branch) }

    subject { described_class.new(branch, path) }

    context 'srpm file exists' do
      before do
        #
        # File.exist?("#{ path }#{ srpm.filename }")
        #
        expect(File).to receive(:exist?)
          .with('/Sisyphus/openbox-1.0-alt1.src.rpm')
          .and_return(true)
      end

      before { expect(subject).to receive(:broadcast).with(:ok) }

      specify do
         expect { subject.call }.not_to raise_error
         expect(srpm.reload).to be_persisted
      end
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

      before { expect(subject).to receive(:broadcast).with(:ok) }

      specify do
         expect { subject.call }.not_to raise_error
         expect { srpm.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
