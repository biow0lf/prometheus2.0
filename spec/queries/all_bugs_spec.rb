require 'rails_helper'

describe AllBugs do
  describe '#initialize' do
    let(:components) { double }

    subject { described_class.new(components) }

    its(:components) { should eq(components) }
  end

  describe '#query' do
    let(:components) { double }

    subject { described_class.new(components) }

    before do
      #
      # Bug.where(component: components).order(bug_id: :desc)
      #
      expect(Bug).to receive(:where).with(component: components) do
        double.tap do |a|
          expect(a).to receive(:order).with(bug_id: :desc)
        end
      end
    end

    specify { expect { subject.query }.not_to raise_error }
  end
end
