# frozen_string_literal: true

require 'rails_helper'

describe AllBugsForSrpm do
  let(:srpm) { double }

  subject { described_class.new(srpm) }

  it { should be_a(Rectify::Query) }

  describe '#initialize' do
    its(:srpm) { should eq(srpm) }
  end

  describe '#query' do
    let(:components) { double }

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

  describe '#decorate' do
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

  # private methods

  describe '#components' do
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
