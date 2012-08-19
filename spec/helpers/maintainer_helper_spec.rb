# encoding: utf-8

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
  end
end
