require 'rails_helper'

describe MaintainerHelper do
  it 'should fix maintainer login' do
    expect(fix_maintainer_email('icesik at altlinux.ru')).to eq('icesik@altlinux.org')
    expect(fix_maintainer_email('icesik at altlinux.ru')).to eq('icesik@altlinux.org')
    expect(fix_maintainer_email('icesik at altlinux.org')).to eq('icesik@altlinux.org')
    expect(fix_maintainer_email('icesik at altlinux.net')).to eq('icesik@altlinux.org')
    expect(fix_maintainer_email('icesik at altlinux.com')).to eq('icesik@altlinux.org')
    expect(fix_maintainer_email('icesik at altlinux dot org')).to eq('icesik@altlinux.org')
    expect(fix_maintainer_email('icesik at altlinux dot ru')).to eq('icesik@altlinux.org')
    expect(fix_maintainer_email('icesik at altlinux dot net')).to eq('icesik@altlinux.org')
    expect(fix_maintainer_email('icesik at altlinux dot com')).to eq('icesik@altlinux.org')
    expect(fix_maintainer_email('icesik@altlinux.ru')).to eq('icesik@altlinux.org')
    expect(fix_maintainer_email('icesik@altlinux.net')).to eq('icesik@altlinux.org')
    expect(fix_maintainer_email('icesik@altlinux.com')).to eq('icesik@altlinux.org')
    expect(fix_maintainer_email('ruby at packages.altlinux.org')).to eq('ruby@packages.altlinux.org')
    expect(fix_maintainer_email('ruby at packages.altlinux.ru')).to eq('ruby@packages.altlinux.org')
    expect(fix_maintainer_email('ruby at packages.altlinux.net')).to eq('ruby@packages.altlinux.org')
    expect(fix_maintainer_email('ruby at packages.altlinux.com')).to eq('ruby@packages.altlinux.org')
    expect(fix_maintainer_email('ruby@packages.altlinux.ru')).to eq('ruby@packages.altlinux.org')
    expect(fix_maintainer_email('ruby@packages.altlinux.net')).to eq('ruby@packages.altlinux.org')
    expect(fix_maintainer_email('ruby@packages.altlinux.com')).to eq('ruby@packages.altlinux.org')
  end
end
