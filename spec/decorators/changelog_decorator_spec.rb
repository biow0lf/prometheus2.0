require 'rails_helper'

describe ChangelogDecorator do
  let(:created_at) { '2015-09-27T16:49:00Z' }

  let(:updated_at) { '2015-09-28T16:59:34Z' }

  let(:changelog) { stub_model Changelog,
    id: 321,
    srpm_id: 43,
    changelogtime: '1264248000',
    changelogname: 'Igor Zubkov <icesik@altlinux.org> 3.4.10-alt2',
    changelogtext: '- update Url:',
    created_at: created_at,
    updated_at: updated_at
  }

  describe '#as_json' do
    subject { changelog.decorate.as_json }

    its([:id]) { should eq(321) }

    its([:srpm_id]) { should eq(43) }

    its([:changelogtime]) { should eq('1264248000') }

    its([:changelogname]) { should eq('Igor Zubkov <icesik@altlinux.org> 3.4.10-alt2') }

    its([:changelogtext]) { should eq('- update Url:') }

    its([:created_at]) { should eq(created_at) }

    its([:updated_at]) { should eq(updated_at) }
  end
end
