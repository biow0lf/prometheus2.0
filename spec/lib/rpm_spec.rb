require 'spec_helper'

describe Rpm do
  it 'should return content of TAG' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    tag = 'NAME'
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{#{ tag }}' #{ file }").and_return('openbox')

    rpm.extract_tag(tag).should == 'openbox'
  end

  it 'should return package name' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{NAME}' #{ file }").and_return('openbox')
    rpm.name.should == 'openbox'
  end

  it 'should return package version' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{VERSION}' #{ file }").and_return('3.4.11.1')
    rpm.version.should == '3.4.11.1'
  end

  it 'should return package release' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{RELEASE}' #{ file }").and_return('alt1.1.1')
    rpm.release.should == 'alt1.1.1'
  end

  it 'should return package epoch' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{EPOCH}' #{ file }").and_return('(none)')
    rpm.epoch.should be_nil
  end

  it 'should return package summary' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{SUMMARY}' #{ file }").and_return('short description')
    rpm.summary.should == 'short description'
  end

  it 'should return package group' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{GROUP}' #{ file }").and_return('Graphical desktop/Other')
    rpm.group.should == 'Graphical desktop/Other'
  end

  it 'should return package packager' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{PACKAGER}' #{ file }").and_return('Igor Zubkov <icesik@altlinux.org>')
    rpm.packager.should == 'Igor Zubkov <icesik@altlinux.org>'
  end

  it 'should return package license' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{LICENSE}' #{ file }").and_return('GPLv2+')
    rpm.license.should == 'GPLv2+'
  end

  it 'should return package url' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{URL}' #{ file }").and_return('http://openbox.org/')
    rpm.url.should == 'http://openbox.org/'
  end

  it 'should return package description' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{DESCRIPTION}' #{ file }").and_return('long description')
    rpm.description.should == 'long description'
  end

  it 'should return package vendor' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{VENDOR}' #{ file }").and_return('ALT Linux Team')
    rpm.vendor.should == 'ALT Linux Team'
  end

  it 'should return package distribution' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{DISTRIBUTION}' #{ file }").and_return('ALT Linux')
    rpm.distribution.should == 'ALT Linux'
  end

  it 'should return package buildtime' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{BUILDTIME}' #{ file }").and_return('1315301838')
    rpm.buildtime.should == '1315301838'
  end

  # TODO: check for real rpm tag for this
  it 'should return package filename' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{NAME}' #{ file }").and_return('openbox')
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{VERSION}' #{ file }").and_return('3.4.11.1')
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{RELEASE}' #{ file }").and_return('alt1.1.1')
    rpm.filename.should == 'openbox-3.4.11.1-alt1.1.1.src.rpm'
  end

#    Srpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{CHANGELOGTIME}' #{file}").and_return('1312545600')
#    Srpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{CHANGELOGNAME}' #{file}").and_return('Igor Zubkov <icesik@altlinux.org> 3.
#    Srpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{CHANGELOGTEXT}' #{file}").and_return('- 3.4.11.1')

#    File.should_receive(:size).with(file).and_return(831617)

  it 'should replace "(none)" with nil in all fields' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    tag = 'URL'
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{#{ tag }}' #{ file }").and_return('(none)')
    rpm.extract_tag(tag).should be_nil
  end

  it 'should replace "(none)" with nil in all fields (second case)' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{URL}' #{ file }").and_return('(none)')
    rpm.url.should be_nil
  end

  it 'should return changelogtime' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{CHANGELOGTIME}' #{ file }").and_return('1312545600')
    rpm.changelogtime.should == '1312545600'
  end

  it 'should return changelogname' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{CHANGELOGNAME}' #{ file }").and_return('Igor Zubkov <icesik@altlinux.org> 3.4.11.1-alt1.1.1')
    rpm.changelogname.should == 'Igor Zubkov <icesik@altlinux.org> 3.4.11.1-alt1.1.1'
  end

  it 'should return changelogtext' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{CHANGELOGTEXT}' #{ file }").and_return('- 3.4.11.1')
    rpm.changelogtext.should == '- 3.4.11.1'
  end

  it 'should return md5 sum of package' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    md5 = "f87ff0eaa4e16b202539738483cd54d1  /Sisyphus/files/SRPMS/#{file}"
    rpm = Rpm.new(file)
    rpm.should_receive(:`).with("/usr/bin/md5sum #{file}").and_return(md5)
    rpm.md5.should == 'f87ff0eaa4e16b202539738483cd54d1'
  end

  it 'should return size of package' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    rpm = Rpm.new(file)
    File.should_receive(:size).and_return(831_617)
    rpm.size.should == 831_617
  end

#  it 'should return sourcerpm' do
#    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
#    rpm = Rpm.new(file)
#    rpm.should_receive(:`).with("export LANG=C && rpm -qp --queryformat='%{CHANGELOGTEXT}' #{ file }").and_return('- 3.4.11.1')
#    rpm.changelogtext.should == '- 3.4.11.1'
#
#      sourcerpm = `export LANG=C && rpm -qp --queryformat='%{SOURCERPM}' #{file}`
#
#  end

  it 'should verify md5 sum of rpm and return true if rpm is OK' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    Rpm.should_receive(:`).with("export LANG=C && rpm -K --nogpg #{file}").and_return("openbox-3.5.0-alt1.src.rpm: md5 OK\n")
    Rpm.check_md5(file).should be_true
  end

  it 'should verify md5 sum of rpm and return false if rpm is broken' do
    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    Rpm.should_receive(:`).with("export LANG=C && rpm -K --nogpg #{file}").and_return("")
    Rpm.check_md5(file).should be_false
  end
end
