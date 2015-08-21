require 'rails_helper'

describe MaintainerDecorator do
  describe '#avatar_url' do
    let(:maintainer) { stub_model Maintainer }

    subject { maintainer.decorate }

    context 'simple case' do
      before { subject.email = 'icesik@altlinux.org' }

      specify do
        expect(subject.avatar_url)
          .to eq('http://gravatar.com/avatar/6b747716cf92a45179b30030d8725ac3.png?s=420&r=g')
      end
    end

    context 'uppercase case' do
      before { subject.email = 'ICESIK@ALTLINUX.ORG' }

      specify do
        expect(subject.avatar_url)
          .to eq('http://gravatar.com/avatar/6b747716cf92a45179b30030d8725ac3.png?s=420&r=g')
      end
    end
  end
end
