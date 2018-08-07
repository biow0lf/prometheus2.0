# frozen_string_literal: true

require 'rails_helper'

describe RemoveOldSrpms do
  let(:branch) { create(:branch) }

  let(:branch_path) { create(:src_branch_path, path: '/Sisyphus', branch: branch) }

  subject { described_class.new(branch_path) }

  it { should be_a(Rectify::Command) }

  describe '#initialize' do
    its(:branch_path) { should eq(branch_path) }
  end

  describe '#call' do
    let!(:srpm) { create(:named_srpm, name: 'openbox-1.0-alt1.src.rpm', branch_path: branch_path) }

    context 'srpm file exists' do
      before do
        #
        # File.exist?("#{ path }#{ srpm.filename }")
        #
        allow(File).to receive(:exist?).and_call_original
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
        allow(File).to receive(:exist?).and_call_original
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
