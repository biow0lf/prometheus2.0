require 'rails_helper'

describe BranchObserver do
  subject { described_class.send(:new) }

  describe '#after_create' do
    let(:branch) { stub_model Branch }

    before do
      #
      # branch.counter.value = 0
      #
      expect(branch).to receive(:counter) do
        double.tap do |a|
          expect(a).to receive(:value=).with(0)
        end
      end
    end

    specify { expect { subject.send(:after_create, branch) }.not_to raise_error }
  end
end
