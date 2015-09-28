require 'rails_helper'

describe BugDecorator do
  let(:created_at) { '2015-09-27T16:49:00Z' }

  let(:updated_at) { '2015-09-28T16:59:34Z' }

  let(:bug) { stub_model Bug,
    bug_id: 22555,
    bug_status: 'NEW',
    resolution: 'IN_PROGRESS',
    bug_severity: 'normal',
    product: 'Sisyphus',
    component: 'cross-component',
    assigned_to: 'icesik@altlinux.org',
    reporter: 'mike@altlinux.org',
    short_desc: 'metabug for prometheus2.0 bugs',
    created_at: created_at,
    updated_at: updated_at
  }

  describe '#as_json' do
    subject { bug.decorate.as_json }

    its([:bug_id]) { should eq(22_555) }

    its([:bug_status]) { should eq('NEW') }

    its([:resolution]) { should eq('IN_PROGRESS') }

    its([:bug_severity]) { should eq('normal') }

    its([:product]) { should eq('Sisyphus') }

    its([:component]) { should eq('cross-component') }

    its([:assigned_to]) { should eq('icesik@altlinux.org') }

    its([:reporter]) { should eq('mike@altlinux.org') }

    its([:short_desc]) { should eq('metabug for prometheus2.0 bugs') }

    its([:created_at]) { should eq(created_at) }

    its([:updated_at]) { should eq(updated_at) }
  end

  subject { bug.decorate }

  its(:bugzilla_url) { should eq('https://bugzilla.altlinux.org/22555') }

  describe '#link_to_bugzilla' do
    before do
      expect(subject).to receive(:h) do
        double.tap do |a|
          expect(a).to receive(:link_to).with(22555, 'https://bugzilla.altlinux.org/22555', class: 'news')
        end
      end
    end

    specify { expect { subject.link_to_bugzilla }.not_to raise_error }
  end
end
