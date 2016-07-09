require 'rails_helper'

describe OpenedBugsForMaintainer do
  let(:branch) { double }

  let(:maintainer) { double }

  subject { described_class.new(branch, maintainer) }

  it { should be_a(Rectify::Query) }

  specify { expect(described_class::BUG_STATUSES).to eq(%w(NEW ASSIGNED VERIFIED REOPENED)) }

  describe '#initialize' do
    let(:scope) { double }

    before do
      #
      # AllBugsForMaintainer.new(branch, maintainer) => scope
      #
      expect(AllBugsForMaintainer).to receive(:new).with(branch, maintainer).and_return(scope)
    end

    its(:scope) { should eq(scope) }
  end

  describe '#query' do
    let(:scope) { double }

    before do
      #
      # AllBugsForMaintainer.new(branch, maintainer) => scope
      #
      expect(AllBugsForMaintainer).to receive(:new).with(branch, maintainer).and_return(scope)
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

  describe '#decorate' do
    let(:scope) { double }

    before do
      #
      # AllBugsForMaintainer.new(branch, maintainer) => scope
      #
      expect(AllBugsForMaintainer).to receive(:new).with(branch, maintainer).and_return(scope)
    end

    before do
      #
      # subject.query.decorate
      #
      expect(subject).to receive(:query) do
        double.tap do |a|
          expect(a).to receive(:decorate)
        end
      end
    end

    specify { expect { subject.decorate }.not_to raise_error }
  end
end
