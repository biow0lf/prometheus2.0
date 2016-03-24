require 'rails_helper'

describe BranchDecorator do
  describe '#as_json' do
    let(:created_at) { double }

    let(:updated_at) { double }

    let(:branch) do
      stub_model Branch,
                 id: 123,
                 name: 'Sisyphus',
                 order_id: 7,
                 path: '/Sisyphus'
    end

    before { expect(branch).to receive(:created_at).and_return(created_at) }

    before { expect(branch).to receive(:updated_at).and_return(updated_at) }

    before { expect(created_at).to receive(:iso8601).and_return(created_at) }

    before { expect(updated_at).to receive(:iso8601).and_return(updated_at) }

    before do
      #
      # branch.srpms.count
      #
      expect(branch).to receive(:srpms) do
        double.tap do |a|
          expect(a).to receive(:count).and_return(43)
        end
      end
    end

    subject { branch.decorate.as_json }

    its([:id]) { should eq(123) }

    its([:name]) { should eq('Sisyphus') }

    its([:order_id]) { should eq(7) }

    its([:path]) { should eq('/Sisyphus') }

    its([:created_at]) { should eq(created_at) }

    its([:updated_at]) { should eq(updated_at) }

    its([:count]) { should eq(43) }
  end
end
