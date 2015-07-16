require 'rails_helper'

describe BranchDecorator do
  describe '#as_json' do
    let(:created_at) { Time.zone.now }

    let(:updated_at) { Time.zone.now }

    let(:branch) do
      stub_model Branch,
        id: 42,
        name: 'Sisyphus',
        order_id: 7,
        path: '/',
        created_at: created_at,
        updated_at: updated_at #,
#        count: 0 # srpms.count
    end

    subject { branch.decorate.as_json }

    its([:id]) { should eq 42 }

    its([:name]) { should eq 'Sisyphus' }

    its([:order_id]) { should eq 7 }

    its([:path]) { should eq '/' }

    its([:created_at]) { should eq created_at.iso8601 }

    its([:updated_at]) { should eq updated_at.iso8601 }
  end
end
