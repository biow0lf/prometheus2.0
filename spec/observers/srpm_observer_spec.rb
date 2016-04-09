require 'rails_helper'

describe SrpmObserver do
  subject { described_class.send(:new) }

  describe '#after_create' do
    let(:srpm) { stub_model Srpm }

    before do
      #
      # srpm.branch.counter.increment
      #
      expect(srpm).to receive(:branch) do
        double.tap do |a|
          expect(a).to receive(:counter) do
            double.tap do |b|
              expect(b).to receive(:increment)
            end
          end
        end
      end
    end

    specify { expect { subject.send(:after_create, srpm) }.not_to raise_error }
  end
end
