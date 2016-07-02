require 'rails_helper'

describe RecountBranchCounter do
  let(:branch) { double }

  subject { described_class.new(branch) }

  it { should be_a(Rectify::Command) }

  describe '#initialize' do
    its(:branch) { should eq(branch) }
  end

  describe '#call' do
    let(:counter) { double }

    before do
      #
      # branch.srpms.count # => counter
      #
      expect(branch).to receive(:srpms) do
        double.tap do |a|
          expect(a).to receive(:count).and_return(counter)
        end
      end
    end

    before do
      #
      # branch.counter.value=(counter)
      #
      expect(branch).to receive(:counter) do
        double.tap do |a|
          expect(a).to receive(:value=).with(counter)
        end
      end
    end

    before { expect(subject).to receive(:broadcast).with(:ok) }

    specify { expect { subject.call }.not_to raise_error }
  end
end
