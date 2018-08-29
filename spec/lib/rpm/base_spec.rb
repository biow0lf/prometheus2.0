# frozen_string_literal: true

require 'rails_helper'

describe Rpm::Base do
  let(:file) { 'spec/data/catpkt-1.0-alt5.src.rpm' }

  subject { described_class.new(file) }

  it { should be_a(Draper::Decoratable) }

  describe '#initialize' do
    its(:file) { should eq('spec/data/catpkt-1.0-alt5.src.rpm') }
  end

  describe '#name' do
    context '@name not set' do
      specify { expect(subject.name).to eq('catpkt') }

      xspecify { expect { subject.name }.to change { subject.instance_variable_get(:@name) }.from(nil).to('catpkt') }
    end

    context '@name is set' do
      let(:name) { "catpkt" }

      before { subject.instance_variable_set(:@name, name) }

      specify { expect(subject.name).to eq(name) }
    end
  end

  describe '#version' do
    context '@version not set' do
      specify { expect(subject.version).to eq('1.0') }

      xspecify { expect { subject.version }.to change { subject.instance_variable_get(:@version) }.from(nil).to('1.0') }
    end

    context '@version is set' do
      let(:version) { "1.0" }

      before { subject.instance_variable_set(:@version, version) }

      specify { expect(subject.version).to eq(version) }
    end
  end

  describe '#release' do
    context '@release not set' do
      specify { expect(subject.release).to eq('alt5') }

      xspecify { expect { subject.release }.to change { subject.instance_variable_get(:@release) }.from(nil).to('alt5') }
    end

    context '@release is set' do
      let(:release) { "alt5" }

      before { subject.instance_variable_set(:@release, release) }

      specify { expect(subject.release).to eq(release) }
    end
  end

  describe '#summary' do
    context '@summary not set' do
      specify { expect(subject.summary).to eq('FTS Packet Viewer') }

      xspecify { expect { subject.summary }.to change { subject.instance_variable_get(:@summary) }.from(nil).to('FTS Packet Viewer') }
    end

    context '@summary is set' do
      let(:summary) { "FTS Packet Viewer" }

      before { subject.instance_variable_set(:@summary, summary) }

      specify { expect(subject.summary).to eq(summary) }
    end
  end

  describe '#group' do
    context '@group not set' do
      specify { expect(subject.group.force_encoding('UTF-8')).to eq('Работа с текстами') }

      xspecify { expect { subject.group.force_encoding('UTF-8') }.to change { subject.instance_variable_get(:@group) }.from(nil).to('Работа с текстами') }
    end

    context '@group is set' do
      let(:group) { "Работа с текстами" }

      before { subject.instance_variable_set(:@group, group) }

      specify { expect(subject.group).to eq(group) }
    end
  end

  describe '#license' do
    context '@license not set' do
      specify { expect(subject.license).to eq('BSD-like') }

      xspecify { expect { subject.license }.to change { subject.instance_variable_get(:@license) }.from(nil).to('BSD-like') }
    end

    context '@license is set' do
      let(:license) { "BSD-like" }

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

      xspecify { expect { subject.url }.to change { subject.instance_variable_get(:@url) }.from(nil).to('http://xmms.org') }
    end

    context '@url is set' do
      let(:url) { nil }

      before { subject.instance_variable_set(:@url, url) }

      specify { expect(subject.url).to eq(url) }
    end
  end

  describe '#packager' do
    context '@packager not set' do
      specify { expect(subject.packager).to eq('Igor Zubkov <icesik@altlinux.org>') }

      xspecify { expect { subject.packager }.to change { subject.instance_variable_get(:@packager) }.from(nil).to('Igor Zubkov <icesik@altlinux.org>') }
    end

    context '@packager is set' do
      let(:packager) { "Igor Zubkov <icesik@altlinux.org>" }

      before { subject.instance_variable_set(:@packager, packager) }

      specify { expect(subject.packager).to eq(packager) }
    end
  end

  describe '#vendor' do
    context '@vendor not set' do
      specify { expect(subject.vendor).to eq('ALT Linux Team') }

      xspecify { expect { subject.vendor }.to change { subject.instance_variable_get(:@vendor) }.from(nil).to('ALT Linux Team') }
    end

    context '@vendor is set' do
      let(:vendor) { "ALT Linux Team" }

      before { subject.instance_variable_set(:@vendor, vendor) }

      specify { expect(subject.vendor).to eq(vendor) }
    end
  end

  describe '#distribution' do
    context '@distribution not set' do
      specify { expect(subject.distribution).to eq('ALT Linux') }

      xspecify { expect { subject.distribution }.to change { subject.instance_variable_get(:@distribution) }.from(nil).to('ALT Linux') }
    end

    context '@distribution is set' do
      let(:distribution) { "ALT Linux" }

      before { subject.instance_variable_set(:@distribution, distribution) }

      specify { expect(subject.distribution).to eq(distribution) }
    end
  end

  describe '#description' do
    context '@description not set' do
      specify { expect(subject.description).to start_with('Viewer for out/in-bound ftn-packets.') }

      specify { expect(subject.description.length).to eq(352) }

      xspecify { expect { subject.description }.to change { subject.instance_variable_get(:@description) }.from(nil) }
    end

    context '@description is set' do
      let(:description) { "Viewer for out/in-bound ftn-packets. Execution catpkt with no parameters\nwill give you help. There is no point address support, maybe, because, I'm\na bit lazy for all this stuff. You can use and modify it for free, the one\nthing I ask you for, is to e-mail me your diffs. Recoding from cp866 charset\nto koi8-r included by default (you can change this)." }

      before { subject.instance_variable_set(:@description, description) }

      specify { expect(subject.description).to eq(description) }
    end
  end

  describe '#buildhost' do
    context '@buildhost not set' do
      specify { expect(subject.buildhost).to eq('icesik.hasher.altlinux.org') }

      xspecify { expect { subject.buildhost }.to change { subject.instance_variable_get(:@buildhost) }.from(nil).to('icesik.hasher.altlinux.org') }
    end

    context '@buildhost is set' do
      let(:buildhost) { "icesik.hasher.altlinux.org" }

      before { subject.instance_variable_set(:@buildhost, buildhost) }

      specify { expect(subject.buildhost).to eq(buildhost) }
    end
  end

  describe '#buildtime' do
    context '@buildtime not set' do
      specify { expect(subject.buildtime).to eq(Time.zone.local(2012, 10, 5, 14, 59, 45)) }

      xspecify { expect { subject.buildtime }.to change { subject.instance_variable_get(:@buildtime) }.from(nil).to(Time.zone.local(2012, 10, 5, 14, 59, 45)) }
    end

    context '@buildtime is set' do
      let(:buildtime) { Time.zone.local(2012, 10, 5, 14, 59, 45) }

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

      xspecify { expect { subject.epoch }.to change { subject.instance_variable_get(:@epoch) }.from(nil).to(20131206) }
    end

    context '@epoch is set' do
      let(:epoch) { nil }

      before { subject.instance_variable_set(:@epoch, epoch) }

      specify { expect(subject.epoch).to eq(epoch) }
    end
  end

  describe '#size' do
    context '@size not set' do
      specify { expect(subject.size).to eq(14_216) }

      xspecify { expect { subject.size }.to change { subject.instance_variable_get(:@size) }.from(nil).to(14_216) }
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

      xspecify { expect { subject.md5 }.to change { subject.instance_variable_get(:@md5) }.from(nil).to('35f0f45bfbcdaf8754713fc1c97f8068') }
    end

    context '@md5 is set' do
      let(:md5) { double }

      before { subject.instance_variable_set(:@md5, md5) }

      specify { expect(subject.md5).to eq(md5) }
    end
  end

  # private methods

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
