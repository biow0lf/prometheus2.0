require 'spec_helper'

describe Bug, :type => :model do
  it { is_expected.to have_db_index :assigned_to }
  it { is_expected.to have_db_index :bug_status }
  it { is_expected.to have_db_index :product }

  it 'should import bugs from url' do
    bugs = `cat spec/data/bugs.csv`
    cmd = 'curl --cacert altlinux.ca --silent "https://bugzilla.altlinux.org/buglist.cgi?ctype=csv"'
    expect(Bug).to receive(:`).with(cmd).and_return(bugs)
    Bug.import('https://bugzilla.altlinux.org/buglist.cgi?ctype=csv')
    expect(Bug.count).to eq(1)
    bug = Bug.first
    expect(bug.bug_id).to eq(22_555)
    expect(bug.bug_status).to eq('CLOSED')
    expect(bug.resolution).to eq('FIXED')
    expect(bug.bug_severity).to eq('blocker')
    expect(bug.product).to eq('Sisyphus')
    expect(bug.component).to eq('openbox')
    expect(bug.assigned_to).to eq('icesik@altlinux.org')
    expect(bug.reporter).to eq('user@email.com')
    expect(bug.short_desc).to eq('segfault')
  end
end
