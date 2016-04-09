require 'rails_helper'

describe SrpmObserver do
  subject { described_class.send(:new) }

  describe '#after_create' do
    let(:srpm) { double }

    before { expect(subject).to receive(:increment_branch_counter).with(srpm) }

    specify { expect { subject.send(:after_create, srpm) }.not_to raise_error }
  end

  describe '#after_destroy' do
    let(:srpm) { double }

    before { expect(subject).to receive(:decrement_branch_counter).with(srpm) }

    specify { expect { subject.send(:after_destroy, srpm) }.not_to raise_error }
  end

  # private methods

  describe '#increment_branch_counter' do
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

    specify { expect { subject.send(:increment_branch_counter, srpm) }.not_to raise_error }
  end

  describe '#decrement_branch_counter' do
    let(:srpm) { stub_model Srpm }

    before do
      #
      # srpm.branch.counter.decrement
      #
      expect(srpm).to receive(:branch) do
        double.tap do |a|
          expect(a).to receive(:counter) do
            double.tap do |b|
              expect(b).to receive(:decrement)
            end
          end
        end
      end
    end

    specify { expect { subject.send(:decrement_branch_counter, srpm) }.not_to raise_error }
  end
end
