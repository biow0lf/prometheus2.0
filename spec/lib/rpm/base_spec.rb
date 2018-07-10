# frozen_string_literal: true

require 'rails_helper'

describe RPM::Base do
  let(:file) { 'spec/data/catpkt-1.0-alt5.src.rpm' }

  subject { described_class.new(file) }

  it { should be_a(Draper::Decoratable) }

  describe '#initialize' do
    its(:file) { should eq('spec/data/catpkt-1.0-alt5.src.rpm') }
  end

  describe '#name' do
    context '@name not set' do
      specify { expect(subject.name).to eq('catpkt') }

      specify { expect { subject.name }.to change { subject.instance_variable_get(:@name) }.from(nil).to('catpkt') }
    end

    context '@name is set' do
      let(:name) { double }

      before { subject.instance_variable_set(:@name, name) }

      specify { expect(subject.name).to eq(name) }
    end
  end

  describe '#version' do
    context '@version not set' do
      specify { expect(subject.version).to eq('1.0') }

      specify { expect { subject.version }.to change { subject.instance_variable_get(:@version) }.from(nil).to('1.0') }
    end

    context '@version is set' do
      let(:version) { double }

      before { subject.instance_variable_set(:@version, version) }

      specify { expect(subject.version).to eq(version) }
    end
  end

  describe '#release' do
    context '@release not set' do
      specify { expect(subject.release).to eq('alt5') }

      specify { expect { subject.release }.to change { subject.instance_variable_get(:@release) }.from(nil).to('alt5') }
    end

    context '@release is set' do
      let(:release) { double }

      before { subject.instance_variable_set(:@release, release) }

      specify { expect(subject.release).to eq(release) }
    end
  end

  describe '#summary' do
    context '@summary not set' do
      specify { expect(subject.summary).to eq('FTS Packet Viewer') }

      specify { expect { subject.summary }.to change { subject.instance_variable_get(:@summary) }.from(nil).to('FTS Packet Viewer') }
    end

    context '@summary is set' do
      let(:summary) { double }

      before { subject.instance_variable_set(:@summary, summary) }

      specify { expect(subject.summary).to eq(summary) }
    end
  end

  describe '#group' do
    context '@group not set' do
      specify { expect(subject.group.force_encoding('UTF-8')).to eq('Работа с текстами') }

      specify { expect { subject.group.force_encoding('UTF-8') }.to change { subject.instance_variable_get(:@group) }.from(nil).to('Работа с текстами') }
    end

    context '@group is set' do
      let(:group) { double }

      before { subject.instance_variable_set(:@group, group) }

      specify { expect(subject.group).to eq(group) }
    end
  end

  describe '#license' do
    context '@license not set' do
      specify { expect(subject.license).to eq('BSD-like') }

      specify { expect { subject.license }.to change { subject.instance_variable_get(:@license) }.from(nil).to('BSD-like') }
    end

    context '@license is set' do
      let(:license) { double }

      before { subject.instance_variable_set(:@license, license) }

      specify { expect(subject.license).to eq(license) }
    end
  end

  describe '#url' do
    context 'url is empty' do
      specify { expect(subject.url).to eq(nil) }
    end

    context '@url not set' do
      let(:file) { 'spec/data/xmms-1.2.11-alt11.src.rpm' }

      specify { expect(subject.url).to eq('http://xmms.org') }

      specify { expect { subject.url }.to change { subject.instance_variable_get(:@url) }.from(nil).to('http://xmms.org') }
    end

    context '@url is set' do
      let(:url) { double }

      before { subject.instance_variable_set(:@url, url) }

      specify { expect(subject.url).to eq(url) }
    end
  end

  describe '#packager' do
    context '@packager not set' do
      specify { expect(subject.packager).to eq('Igor Zubkov <icesik@altlinux.org>') }

      specify { expect { subject.packager }.to change { subject.instance_variable_get(:@packager) }.from(nil).to('Igor Zubkov <icesik@altlinux.org>') }
    end

    context '@packager is set' do
      let(:packager) { double }

      before { subject.instance_variable_set(:@packager, packager) }

      specify { expect(subject.packager).to eq(packager) }
    end
  end

  describe '#vendor' do
    context '@vendor not set' do
      specify { expect(subject.vendor).to eq('ALT Linux Team') }

      specify { expect { subject.vendor }.to change { subject.instance_variable_get(:@vendor) }.from(nil).to('ALT Linux Team') }
    end

    context '@vendor is set' do
      let(:vendor) { double }

      before { subject.instance_variable_set(:@vendor, vendor) }

      specify { expect(subject.vendor).to eq(vendor) }
    end
  end

  describe '#distribution' do
    context '@distribution not set' do
      specify { expect(subject.distribution).to eq('ALT Linux') }

      specify { expect { subject.distribution }.to change { subject.instance_variable_get(:@distribution) }.from(nil).to('ALT Linux') }
    end

    context '@distribution is set' do
      let(:distribution) { double }

      before { subject.instance_variable_set(:@distribution, distribution) }

      specify { expect(subject.distribution).to eq(distribution) }
    end
  end

  describe '#description' do
    context '@description not set' do
      specify { expect(subject.description).to start_with('Viewer for out/in-bound ftn-packets.') }

      specify { expect(subject.description.length).to eq(352) }

      specify { expect { subject.description }.to change { subject.instance_variable_get(:@description) }.from(nil) }
    end

    context '@description is set' do
      let(:description) { double }

      before { subject.instance_variable_set(:@description, description) }

      specify { expect(subject.description).to eq(description) }
    end
  end

  describe '#buildhost' do
    context '@buildhost not set' do
      specify { expect(subject.buildhost).to eq('icesik.hasher.altlinux.org') }

      specify { expect { subject.buildhost }.to change { subject.instance_variable_get(:@buildhost) }.from(nil).to('icesik.hasher.altlinux.org') }
    end

    context '@buildhost is set' do
      let(:buildhost) { double }

      before { subject.instance_variable_set(:@buildhost, buildhost) }

      specify { expect(subject.buildhost).to eq(buildhost) }
    end
  end

  describe '#changelogname' do
    context '@changelogname not set' do
      specify { expect(subject.changelogname).to eq('Igor Zubkov <icesik@altlinux.org> 1.0-alt5') }

      specify { expect { subject.changelogname }.to change { subject.instance_variable_get(:@changelogname) }.from(nil).to('Igor Zubkov <icesik@altlinux.org> 1.0-alt5') }
    end

    context '@changelogname is set' do
      let(:changelogname) { double }

      before { subject.instance_variable_set(:@changelogname, changelogname) }

      specify { expect(subject.changelogname).to eq(changelogname) }
    end
  end

  describe '#changelogtext' do
    context '@changelogtext not set' do
      specify { expect(subject.changelogtext).to eq('- rebuilt for debuginfo') }

      specify { expect { subject.changelogtext }.to change { subject.instance_variable_get(:@changelogtext) }.from(nil).to('- rebuilt for debuginfo') }
    end

    context '@changelogtext is set' do
      let(:changelogtext) { double }

      before { subject.instance_variable_set(:@changelogtext, changelogtext) }

      specify { expect(subject.changelogtext).to eq(changelogtext) }
    end
  end

  describe '#changelogtime' do
    context '@changelogtime not set' do
      specify { expect(subject.changelogtime).to eq(Time.zone.local(2012, 10, 5, 12, 0)) }

      specify { expect { subject.changelogtime }.to change { subject.instance_variable_get(:@changelogtime) }.from(nil).to(Time.zone.local(2012, 10, 5, 12, 0)) }
    end

    context '@changelogtime is set' do
      let(:changelogtime) { double }

      before { subject.instance_variable_set(:@changelogtime, changelogtime) }

      specify { expect(subject.changelogtime).to eq(changelogtime) }
    end
  end

  describe '#buildtime' do
    context '@buildtime not set' do
      specify { expect(subject.buildtime).to eq(Time.zone.local(2012, 10, 5, 14, 59, 45)) }

      specify { expect { subject.buildtime }.to change { subject.instance_variable_get(:@buildtime) }.from(nil).to(Time.zone.local(2012, 10, 5, 14, 59, 45)) }
    end

    context '@buildtime is set' do
      let(:buildtime) { double }

      before { subject.instance_variable_set(:@buildtime, buildtime) }

      specify { expect(subject.buildtime).to eq(buildtime) }
    end
  end

  describe '#epoch' do
    context 'epoch is empty' do
      specify { expect(subject.epoch).to eq(nil) }
    end

    context '@epoch not set' do
      let(:file) { 'spec/data/xmms-1.2.11-alt11.src.rpm' }

      specify { expect(subject.epoch).to eq(20131206) }

      specify { expect { subject.epoch }.to change { subject.instance_variable_get(:@epoch) }.from(nil).to(20131206) }
    end

    context '@epoch is set' do
      let(:epoch) { double }

      before { subject.instance_variable_set(:@epoch, epoch) }

      specify { expect(subject.epoch).to eq(epoch) }
    end
  end

  describe '#packagesize' do
    context '@packagesize not set' do
      if (RPM::Base.version != "4.0.4")
        specify { expect(subject.packagesize).to eq(14_216) }

        specify { expect { subject.packagesize }.to change { subject.instance_variable_get(:@packagesize) }.from(nil).to(14_216) }
      end
    end

    context '@packagesize is set' do
      let(:packagesize) { double }

      before { subject.instance_variable_set(:@packagesize, packagesize) }

      specify { expect(subject.packagesize).to eq(packagesize) }
    end
  end

  describe '#size' do
    context '@size not set' do
      specify { expect(subject.size).to eq(14_216) }

      specify { expect { subject.size }.to change { subject.instance_variable_get(:@size) }.from(nil).to(14_216) }
    end

    context '@size is set' do
      let(:size) { double }

      before { subject.instance_variable_set(:@size, size) }

      specify { expect(subject.size).to eq(size) }
    end
  end

  describe '#md5' do
    context '@md5 not set' do
      specify { expect(subject.md5).to eq('35f0f45bfbcdaf8754713fc1c97f8068') }

      specify { expect { subject.md5 }.to change { subject.instance_variable_get(:@md5) }.from(nil).to('35f0f45bfbcdaf8754713fc1c97f8068') }
    end

    context '@md5 is set' do
      let(:md5) { double }

      before { subject.instance_variable_set(:@md5, md5) }

      specify { expect(subject.md5).to eq(md5) }
    end
  end

  # private methods

  describe '#read_int' do
    context 'nil' do
      let(:tag) { double }

      before { expect(subject).to receive(:read).with(tag).and_return(nil) }

      specify { expect(subject.send(:read_int, tag)).to eq(nil) }
    end

    context 'number' do
      let(:tag) { double }

      before { expect(subject).to receive(:read).with(tag).and_return('20131206') }

      specify { expect(subject.send(:read_int, tag)).to eq(20131206) }
    end
  end

  describe '#read_time' do
    let(:tag) { double }

    before { expect(subject).to receive(:read).with(tag).and_return('1349449185') }

    specify { expect(subject.send(:read_time, tag)).to eq(Time.zone.local(2012, 10, 5, 14, 59, 45)) }
  end

  xdescribe '#read' do
    context '(none)' do
      let(:tag) { double }

      let(:read_raw) { '(none)' }

      before { expect(subject).to receive(:read_raw).with(tag).and_return(read_raw) }

      specify { expect(subject.send(:read, tag)).to eq(nil) }
    end

    context '"" (empty)' do
      let(:tag) { double }

      let(:read_raw) { '' }

      before { expect(subject).to receive(:read_raw).with(tag).and_return(read_raw) }

      specify { expect(subject.send(:read, tag)).to eq(nil) }
    end

    context 'ok' do
      let(:tag) { double }

      let(:read_raw) { 'raw' }

      before { expect(subject).to receive(:read_raw).with(tag).and_return(read_raw) }

      specify { expect(subject.send(:read, tag)).to eq('raw') }
    end
  end

  xdescribe '#read_raw' do
    context 'read tag' do
      let(:tag) { '%{NAME}' }

      specify { expect(subject.send(:read_raw, tag)).to eq('catpkt') }
    end

    context 'rpm command not found' do
      let(:tag) { double }

      before do
        #
        # Cocaine::CommandLine.new('rpm', '-qp --queryformat=:tag :file', environment: { 'LANG' => 'C' })
        #
        expect(Cocaine::CommandLine).to receive(:new).with('rpm', '-qp --queryformat=:tag :file', environment: { 'LANG' => 'C' }).and_raise(Cocaine::CommandNotFoundError)
      end

      before do
        #
        # Rails.logger.info('rpm command not found')
        #
        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with('rpm command not found')
          end
        end
      end

      specify { expect { subject.send(:read_raw, tag) }.not_to raise_error }
    end

    context 'rpm exit status non zero' do
      let(:tag) { double }

      before do
        #
        # Cocaine::CommandLine.new('rpm', '-qp --queryformat=:tag :file', environment: { 'LANG' => 'C' })
        #
        expect(Cocaine::CommandLine).to receive(:new).with('rpm', '-qp --queryformat=:tag :file', environment: { 'LANG' => 'C' }).and_raise(Cocaine::ExitStatusError)
      end

      before do
        #
        # Rails.logger.info('rpm exit status non zero')
        #
        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with('rpm exit status non zero')
          end
        end
      end

      specify { expect { subject.send(:read_raw, tag) }.not_to raise_error }
    end
  end
end
