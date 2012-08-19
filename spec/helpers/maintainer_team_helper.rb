# encoding: utf-8

require 'spec_helper'

describe MaintainerTeamHelper do
  it "should fix maintainer team login" do
    fix_maintainer_email('ruby at packages.altlinux.org').should == 'ruby@packages.altlinux.org'
    fix_maintainer_email('ruby at packages.altlinux.ru').should == 'ruby@packages.altlinux.org'
    fix_maintainer_email('ruby at packages.altlinux.net').should == 'ruby@packages.altlinux.org'
    fix_maintainer_email('ruby at packages.altlinux.com').should == 'ruby@packages.altlinux.org'
    fix_maintainer_email('ruby@packages.altlinux.ru').should == 'ruby@packages.altlinux.org'
    fix_maintainer_email('ruby@packages.altlinux.net').should == 'ruby@packages.altlinux.org'
    fix_maintainer_email('ruby@packages.altlinux.com').should == 'ruby@packages.altlinux.org'
  end
end
