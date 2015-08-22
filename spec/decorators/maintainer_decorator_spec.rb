require 'rails_helper'

describe MaintainerDecorator do
  let(:maintainer) { Maintainer.new }
  subject { maintainer.decorate }

  it 'does return gravatar url for maintainer email' do
    maintainer.email = 'icesik@altlinux.org'
    expect(subject.avatar_url)
      .to eq('http://gravatar.com/avatar/6b747716cf92a45179b30030d8725ac3.png?s=420&r=g')
  end

  it 'does return gravatar url for maintainer email (second case)' do
    maintainer.email = 'ICESIK@ALTLINUX.ORG'
    expect(subject.avatar_url)
      .to eq('http://gravatar.com/avatar/6b747716cf92a45179b30030d8725ac3.png?s=420&r=g')
  end
end
