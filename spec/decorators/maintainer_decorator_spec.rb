require 'rails_helper'

describe MaintainerDecorator do
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
