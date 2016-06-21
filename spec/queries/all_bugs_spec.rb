require 'rails_helper'

describe AllBugs do
  describe '#initialize' do
    let(:components) { double }

    subject { described_class.new(components) }

    its(:components) { should eq(components) }
  end

  describe '#query' do
    # def query
    #   Bug.where(component: components)
    # end

    let(:components) { double }

    subject { described_class.new(components) }

    before do
      #
      # Bug.where(component: components)
      #
      expect(Bug).to receive(:where).with(component: components)
    end

    specify { expect { subject.query }.not_to raise_error }
  end
end
