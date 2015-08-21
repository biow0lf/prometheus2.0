require 'rails_helper'

describe BugDecorator do
  describe '#as_json' do
    let(:created_at) { Time.zone.now }

    let(:updated_at) { Time.zone.now }

    let(:bug) do
      stub_model Bug,
        bug_id: 22_555,
        bug_status: 'Some status',
        resolution: 'Some resolution',
        bug_severity: 'Some severity',
        product: 'Some product',
        component: 'Some component',
        assigned_to: 'not_me@example.com',
        reporter: 'me@example.com',
        short_desc: 'short description',
        created_at: created_at,
        updated_at: updated_at
    end

    subject { bug.decorate.as_json }

    its([:bug_id]) { should eq 22_555 }

    its([:bug_status]) { should eq 'Some status' }

    its([:resolution]) { should eq 'Some resolution' }

    its([:bug_severity]) { should eq 'Some severity' }

    its([:product]) { should eq 'Some product' }

    its([:component]) { should eq 'Some component' }

    its([:assigned_to]) { should eq 'not_me@example.com' }

    its([:reporter]) { should eq 'me@example.com' }

    its([:short_desc]) { should eq 'short description' }

    its([:created_at]) { should eq created_at.iso8601 }

    its([:updated_at]) { should eq updated_at.iso8601 }
  end
end
