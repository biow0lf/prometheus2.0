require 'rails_helper'

describe MaintainerDecorator do
  describe '#as_json' do
    let(:created_at) { '2015-09-27T16:49:00Z' }

    let(:updated_at) { '2015-09-28T16:59:34Z' }

    let(:maintainer) do
      stub_model Maintainer,
                 id: 3,
                 name: 'Igor Zubkov',
                 email: 'icesik@altlinux.org',
                 login: 'icesik',
                 time_zone: 'Europe/Kiev',
                 jabber: 'icesik@altlinux.org',
                 info: 'Hello, World!',
                 website: 'http://biow0lf.pp.ua',
                 location: 'Ukraine',
                 created_at: created_at,
                 updated_at: updated_at
    end

    subject { maintainer.decorate.as_json }

    its([:id]) { should eq(3) }

    its([:name]) { should eq('Igor Zubkov') }

    its([:email]) { should eq('icesik@altlinux.org') }

    its([:login]) { should eq('icesik') }

    its([:time_zone]) { should eq('Europe/Kiev') }

    its([:jabber]) { should eq('icesik@altlinux.org') }

    its([:info]) { should eq('Hello, World!') }

    its([:website]) { should eq('http://biow0lf.pp.ua') }

    its([:location]) { should eq('Ukraine') }

    its([:created_at]) { should eq(created_at) }

    its([:updated_at]) { should eq(updated_at) }
  end

  describe '#avatar_url' do
    let(:maintainer) { stub_model Maintainer }

    subject { maintainer.decorate }

    before do
      expect(subject).to receive(:gravatar_id).and_return('6b747716cf92a45179b30030d8725ac3')
    end

    specify { expect(subject.avatar_url).to eq('http://gravatar.com/avatar/6b747716cf92a45179b30030d8725ac3.png?s=420&r=g') }
  end

  # private methods

  describe '#gravatar_id' do
    let(:maintainer) { stub_model Maintainer, email: 'ICESIK@ALTLINUX.ORG' }

    subject { maintainer.decorate }

    before do
      expect(subject).to receive(:email) do
        double.tap do |a|
          expect(a).to receive(:downcase).and_return('icesik@altlinux.org')
        end
      end
    end

    before do
      expect(Digest::MD5).to receive(:hexdigest).with('icesik@altlinux.org')
    end

    specify { expect { subject.send(:gravatar_id) }.not_to raise_error }
  end
end
