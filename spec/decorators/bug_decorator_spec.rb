# frozen_string_literal: true

require 'rails_helper'

describe BugDecorator do
  describe '#as_json' do
    let(:created_at) { double }

    let(:updated_at) { double }

    let(:bug) do
      stub_model Bug,
                 bug_id: 22_555,
                 bug_status: 'NEW',
                 resolution: 'IN_PROGRESS',
                 bug_severity: 'normal',
                 product: 'Sisyphus',
                 component: 'cross-component',
                 assigned_to: 'icesik@altlinux.org',
                 reporter: 'mike@altlinux.org',
                 short_desc: 'metabug for prometheus2.0 bugs'
    end

    before { expect(bug).to receive(:created_at).and_return(created_at) }

    before { expect(bug).to receive(:updated_at).and_return(updated_at) }

    before { expect(created_at).to receive(:iso8601).and_return(created_at) }

    before { expect(updated_at).to receive(:iso8601).and_return(updated_at) }

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

  describe '#bugzilla_url' do
    let(:bug) { stub_model Bug, bug_id: 22_555 }

    subject { bug.decorate }

    its(:bugzilla_url) { should eq('https://bugzilla.altlinux.org/22555') }
  end

  describe '#link_to_bugzilla' do
    let(:bug) { stub_model Bug, bug_id: 22_555 }

    subject { bug.decorate }

    before do
      #
      # subject.h.link_to(22_555, 'https://bugzilla.altlinux.org/22555', class: 'news')
      #
      expect(subject).to receive(:h) do
        double.tap do |a|
          expect(a).to receive(:link_to).with(22_555, 'https://bugzilla.altlinux.org/22555', class: 'news')
        end
      end
    end

    specify { expect { subject.link_to_bugzilla }.not_to raise_error }
  end
end
