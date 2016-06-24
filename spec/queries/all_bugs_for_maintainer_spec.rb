require 'rails_helper'

describe AllBugsForMaintainer do
  describe '#initialize' do
    let(:branch) { double }

    let(:maintainer) { double }

    subject { described_class.new(branch, maintainer) }

    its(:branch) { should eq(branch) }

    its(:maintainer) { should eq(maintainer) }
  end

  # TODO: write
end
