require 'rails_helper'

describe RPM::Base do
  let(:file) { 'spec/data/catpkt-1.0-alt5.src.rpm' }

  subject { described_class.new(file) }

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
      specify { expect(subject.group).to eq('Text tools') }

      specify { expect { subject.group }.to change { subject.instance_variable_get(:@group) }.from(nil).to('Text tools') }
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
    # context '@url not set' do
    #   specify { expect(subject.url).to eq('BSD-like') }
    #
    #   specify { expect { subject.url }.to change { subject.instance_variable_get(:@license) }.from(nil).to('BSD-like') }
    # end

    # context '@url is set' do
    #   let(:url) { double }
    #
    #   before { subject.instance_variable_set(:@url, url) }
    #
    #   specify { expect(subject.url).to eq(url) }
    # end
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


#   def description
#     @description ||= read('%{DESCRIPTION}')
#   end
#
#   def buildhost
#     @buildhost ||= read('%{BUILDHOST}')
#   end
#
#   def changelogname
#     @changelogname ||= read('%{CHANGELOGNAME}')
#   end
#
#   def changelogtext
#     @changelogtext ||= read('%{CHANGELOGTEXT}')
#   end
#
#   def changelogtime
#     @changelogtime ||= read_time('%{CHANGELOGTIME}')
#   end
#
#   def buildtime
#     @buildtime ||= read_time('%{BUILDTIME}')
#   end
#
#   def epoch
#     @epoch ||= read_int('%{EPOCH}')
#   end
#
#   private
#
#   def read_int(tag)
#     output = read(tag)
#     output ? output.to_i : output
#   end
#
#   def read_time(tag)
#     Time.zone.at(read(tag).to_i)
#   end
#
#   def read(tag)
#     output = read_raw(tag)
#
#     output = nil if ['(none)', ''].include?(output)
#
#     output
#   end
#
#   def read_raw(tag)
#     cocaine = Cocaine::CommandLine.new('rpm', '-qp --queryformat=:tag :file')
#
#     cocaine.run(tag: tag, file: file)
#   rescue Cocaine::CommandNotFoundError
#     Rails.logger.info('rpm command not found')
#   rescue Cocaine::ExitStatusError
#     Rails.logger.info('rpm exit status non zero')
#   end
end
