require 'spec_helper'

describe MaintainerHelper do
  it "should fix maintainer login" do
    fix_maintainer_email('icesik at altlinux.ru').should == 'icesik@altlinux.org'
    fix_maintainer_email('icesik at altlinux.ru').should == 'icesik@altlinux.org'
    fix_maintainer_email('icesik at altlinux.org').should == 'icesik@altlinux.org'
    fix_maintainer_email('icesik at altlinux.net').should == 'icesik@altlinux.org'
    fix_maintainer_email('icesik at altlinux.com').should == 'icesik@altlinux.org'
    fix_maintainer_email('icesik at altlinux dot org').should == 'icesik@altlinux.org'
    fix_maintainer_email('icesik at altlinux dot ru').should == 'icesik@altlinux.org'
    fix_maintainer_email('icesik at altlinux dot net').should == 'icesik@altlinux.org'
    fix_maintainer_email('icesik at altlinux dot com').should == 'icesik@altlinux.org'
    fix_maintainer_email('icesik@altlinux.ru').should == 'icesik@altlinux.org'
    fix_maintainer_email('icesik@altlinux.net').should == 'icesik@altlinux.org'
    fix_maintainer_email('icesik@altlinux.com').should == 'icesik@altlinux.org'
    # fix_maintainer_email( ' at packages.altlinux.org', '@packages.altlinux.org')
    # fix_maintainer_email( ' at packages.altlinux.ru', '@packages.altlinux.org')
    # fix_maintainer_email( ' at packages.altlinux.net', '@packages.altlinux.org')
    # fix_maintainer_email( ' at packages.altlinux.com', '@packages.altlinux.org')
    # fix_maintainer_email( '@packages.altlinux.ru', '@packages.altlinux.org')
    # fix_maintainer_email( '@packages.altlinux.net', '@packages.altlinux.org')
    # fix_maintainer_email( '@packages.altlinux.com', '@packages.altlinux.org')
  end
end
