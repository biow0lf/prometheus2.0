require 'spec_helper'

describe MaintainerHelper do
  it 'should fix maintainer login' do
    fix_maintainer_email('icesik at altlinux.ru').should eq('icesik@altlinux.org')
    fix_maintainer_email('icesik at altlinux.ru').should eq('icesik@altlinux.org')
    fix_maintainer_email('icesik at altlinux.org').should eq('icesik@altlinux.org')
    fix_maintainer_email('icesik at altlinux.net').should eq('icesik@altlinux.org')
    fix_maintainer_email('icesik at altlinux.com').should eq('icesik@altlinux.org')
    fix_maintainer_email('icesik at altlinux dot org').should eq('icesik@altlinux.org')
    fix_maintainer_email('icesik at altlinux dot ru').should eq('icesik@altlinux.org')
    fix_maintainer_email('icesik at altlinux dot net').should eq('icesik@altlinux.org')
    fix_maintainer_email('icesik at altlinux dot com').should eq('icesik@altlinux.org')
    fix_maintainer_email('icesik@altlinux.ru').should eq('icesik@altlinux.org')
    fix_maintainer_email('icesik@altlinux.net').should eq('icesik@altlinux.org')
    fix_maintainer_email('icesik@altlinux.com').should eq('icesik@altlinux.org')
    fix_maintainer_email('ruby at packages.altlinux.org').should eq('ruby@packages.altlinux.org')
    fix_maintainer_email('ruby at packages.altlinux.ru').should eq('ruby@packages.altlinux.org')
    fix_maintainer_email('ruby at packages.altlinux.net').should eq('ruby@packages.altlinux.org')
    fix_maintainer_email('ruby at packages.altlinux.com').should eq('ruby@packages.altlinux.org')
    fix_maintainer_email('ruby@packages.altlinux.ru').should eq('ruby@packages.altlinux.org')
    fix_maintainer_email('ruby@packages.altlinux.net').should eq('ruby@packages.altlinux.org')
    fix_maintainer_email('ruby@packages.altlinux.com').should eq('ruby@packages.altlinux.org')
  end
end
