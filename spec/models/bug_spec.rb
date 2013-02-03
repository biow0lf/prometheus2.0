# encoding: utf-8

require 'spec_helper'

describe Bug do
  it { should have_db_index :assigned_to }
  it { should have_db_index :bug_status }
  it { should have_db_index :product }

  it 'should import bugs from url' do
    bugs = `cat spec/data/bugs.csv`
    Bug.should_receive(:`).with('curl --silent "https://bugzilla.altlinux.org/buglist.cgi?ctype=csv"').and_return(bugs)
    Bug.import('https://bugzilla.altlinux.org/buglist.cgi?ctype=csv')
    Bug.count.should == 1
    bug = Bug.first
    bug.bug_id.should == 22555
    bug.bug_status.should == 'CLOSED'
    bug.resolution.should == 'FIXED'
    bug.bug_severity.should == 'blocker'
    bug.product.should == 'Sisyphus'
    bug.component.should == 'openbox'
    bug.assigned_to.should == 'icesik@altlinux.org'
    bug.reporter.should == 'user@email.com'
    bug.short_desc.should == 'segfault'
  end
end
