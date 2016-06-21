require 'rails_helper'

describe OpenedBugs do
  specify { expect(described_class::BUG_STATUSES).to eq(%w(NEW ASSIGNED VERIFIED REOPENED)) }

  describe '#initialize' do
    let(:components) { double }

    let(:scope) { double }

    subject { described_class.new(components) }

    before do
      #
      # AllBugs.new(components) => scope
      #
      expect(AllBugs).to receive(:new).with(components).and_return(scope)
    end

    its(:scope) { should eq(scope) }
  end

  describe '#query' do
    let(:components) { double }

    let(:scope) { double }

    subject { described_class.new(components) }

    before do
      #
      # AllBugs.new(components) => scope
      #
      expect(AllBugs).to receive(:new).with(components).and_return(scope)
    end

    before do
      #
      # scope.query.where(bug_status: BUG_STATUSES).order(bug_id: :desc)
      #
      expect(scope).to receive(:query) do
        double.tap do |a|
          expect(a).to receive(:where).with(bug_status: described_class::BUG_STATUSES) do
            double.tap do |b|
              expect(b).to receive(:order).with(bug_id: :desc)
            end
          end
        end
      end
    end

    specify { expect { subject.query }.not_to raise_error }
  end
end
