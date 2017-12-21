# frozen_string_literal: true

require 'rails_helper'

describe RecountBranchCounter do
  let(:branch) { double }

  subject { described_class.new(branch) }

  it { should be_a(Rectify::Command) }

  describe '#initialize' do
    its(:branch) { should eq(branch) }
  end

  describe '#call' do
    context 'ok' do
      let(:counter) { double }

      before do
        #
        # Redis.current.connected? # => true
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:connected?).and_return(true)
          end
        end
      end

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

    context 'failed' do
      before do
        #
        # Redis.current.connected? # => false
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:connected?).and_return(false)
          end
        end
      end

      before { expect(subject).to receive(:broadcast).with(:failed) }

      specify { expect { subject.call }.not_to raise_error }
    end
  end
end
