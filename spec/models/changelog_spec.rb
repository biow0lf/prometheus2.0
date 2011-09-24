require 'spec_helper'

describe Changelog do
  it { should belong_to :srpm }

  it { should validate_presence_of :srpm }
  it { should validate_presence_of :changelogtime }
  it { should validate_presence_of :changelogname }
  it { should validate_presence_of :changelogtext }

  it { should have_db_index :srpm_id }

  it "should import changelogs" do
    branch = FactoryGirl.create(:branch)
    group = FactoryGirl.create(:group, branch_id: branch.id)
    srpm = FactoryGirl.create(:srpm, branch_id: branch.id, group_id: group.id)

    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    Changelog.should_receive(:`).with("rpm -qp --queryformat='[%{CHANGELOGTIME}\n**********\n%{CHANGELOGNAME}\n**********\n%{CHANGELOGTEXT}\n**********\n]' #{file}").and_return("1312545600\n**********\nMykola Grechukh <gns@altlinux.ru> 3.5.0-alt1\n**********\n3.4.11.1 -> 3.5.0\n**********\n1312545600\n**********\nMykola Grechukh <gns@altlinux.ru> 3.5.0-alt1\n**********\n3.4.11.1 -> 3.5.0\n**********\n")

    expect{
      Changelog.import(branch, file, srpm)
    }.to change{ Changelog.count }.from(0).to(2)
  end
end
