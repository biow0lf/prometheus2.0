require 'rails_helper'

describe BranchDecorator do
  let(:created_at) { '2015-09-27T16:49:00Z' }

  let(:updated_at) { '2015-09-28T16:59:34Z' }

  let(:branch) do
    stub_model Branch,
               id: 123,
               name: 'Sisyphus',
               order_id: 7,
               path: '/Sisyphus',
               created_at: created_at,
               updated_at: updated_at
  end

  describe '#as_json' do
    subject { branch.decorate.as_json }

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

    its([:id]) { should eq(123) }

    its([:name]) { should eq('Sisyphus') }

    its([:order_id]) { should eq(7) }

    its([:path]) { should eq('/Sisyphus') }

    its([:created_at]) { should eq(created_at) }

    its([:updated_at]) { should eq(updated_at) }

    its([:count]) { should eq(43) }
  end
end
