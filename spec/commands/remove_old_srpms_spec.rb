# frozen_string_literal: true

require 'rails_helper'

describe RemoveOldSrpms do
  let(:branch) { create(:branch) }

  let(:branch_path) { create(:src_branch_path, path: 'spec/data', branch: branch) }

  subject { described_class.new(branch_path) }

  it { should be_a(Rectify::Command) }

  describe '#initialize' do
    its(:branch_path) { should eq(branch_path) }
  end
end
