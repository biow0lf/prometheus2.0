require 'rails_helper'

describe AllSrpmsWithName do
  let(:name) { double }

  subject { described_class.new(name) }

  it { should be_a(Rectify::Query) }

  describe '#initialize' do
    its(:name) { should eq(name) }
  end

  describe '#query' do
    before do
      #
      # Srpm.where(name: name).includes(:branch).order('branches.order_id')
      #
      expect(Srpm).to receive(:where).with(name: name) do
        double.tap do |a|
          expect(a).to receive(:includes).with(:branch) do
            double.tap do |b|
              expect(b).to receive(:order).with('branches.order_id')
            end
          end
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
end