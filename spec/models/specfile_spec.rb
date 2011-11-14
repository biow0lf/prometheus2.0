# encoding: utf-8

require 'spec_helper'

describe Specfile do
  it { should belong_to :branch }
  it { should belong_to :srpm }

  it { should validate_presence_of :branch }
  it { should validate_presence_of :srpm }
  it { should validate_presence_of :spec }

  it "should import spec file" do
    branch = FactoryGirl.create(:branch)
    group = FactoryGirl.create(:group, branch_id: branch.id)
    srpm = FactoryGirl.create(:srpm, branch_id: branch.id, group_id: group.id)
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'

    Specfile.should_receive(:`).with("rpm -qp --queryformat=\"[%{FILEFLAGS} %{FILENAMES}\n]\" \"#{file}\" | grep \"32 \" | sed -e 's/32 //'").and_return('openbox.spec')
    Specfile.should_receive(:`).with("rpm2cpio \"#{file}\" | cpio -i --to-stdout \"openbox.spec\"").and_return("qwerty")

    expect{
      Specfile.import(branch, file, srpm)
      }.to change{ Specfile.count }.from(0).to(1)

    srpm.specfile.should_not be_nil
    srpm.specfile.spec.should == 'qwerty'

    specfile = Specfile.first
    specfile.srpm.should_not be_nil
  end
end
