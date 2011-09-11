require 'spec_helper'

describe RPM do
  it "should verify md5 sum of srpm before import and return true for good srpm" do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    RPM.should_receive(:`).with("rpm -K --nogpg #{file}").and_return("openbox-3.5.0-alt1.src.rpm: md5 OK\n")
    RPM.check_md5(file).should be_true
  end

  it "should verify md5 sum of srpm before import and return false for broken srpm" do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    RPM.should_receive(:`).with("rpm -K --nogpg #{file}").and_return("")
    RPM.check_md5(file).should be_false
  end
end
