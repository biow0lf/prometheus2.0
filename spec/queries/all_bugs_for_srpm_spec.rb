require 'rails_helper'

describe AllBugsForSrpm do
  describe '#initialize' do
    let(:srpm) { double }

    subject { described_class.new(srpm) }

    its(:srpm) { should eq(srpm) }
  end

  describe '#query' do
    let(:srpm) { double }

    let(:components) { double }

    subject { described_class.new(srpm) }

    before { expect(subject).to receive(:components).and_return(components) }

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

  # private methods

  describe '#components' do
    let(:srpm) { double }

    subject { described_class.new(srpm) }

    before do
      #
      # srpm.packages.pluck(:name).flatten.sort.uniq
      #
      expect(srpm).to receive(:packages) do
        double.tap do |a|
          expect(a).to receive(:pluck).with(:name) do
            double.tap do |b|
              expect(b).to receive(:flatten) do
                double.tap do |c|
                  expect(c).to receive(:sort) do
                    double.tap do |d|
                      expect(d).to receive(:uniq)
                    end
                  end
                end
              end
            end
          end
        end
      end
    end

    specify { expect { subject.send(:components) }.not_to raise_error }
  end
end
