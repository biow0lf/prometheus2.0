# frozen_string_literal: true

require 'rails_helper'

module Extractor
  module RPM
    describe Source do
      let(:file) { Rails.root.join('spec', 'fixtures', 'fedora', 'glibc-2.27-19.fc28', 'glibc-2.27-19.fc28.src.rpm') }

      subject { Extractor::RPM::Source.new(file) }

      it { should be_an(Extractor::RPM::Base) }

      describe '#as_json' do
        let(:name) { double }

        let(:version) { double }

        let(:release) { double }

        let(:epoch) { double }

        let(:summary) { double }

        let(:group) { double }

        let(:license) { double }

        let(:url) { double }

        let(:packager) { double }

        let(:vendor) { double }

        let(:distribution) { double }

        let(:description) { double }

        let(:buildhost) { double }

        let(:filename) { double }

        let(:filesize) { double }

        let(:md5) { double }

        let(:source) { Extractor::RPM::Source.new(file) }

        subject { source.as_json }

        before { expect(source).to receive(:name).and_return(name) }

        before { expect(source).to receive(:version).and_return(version) }

        before { expect(source).to receive(:release).and_return(release) }

        before { expect(source).to receive(:epoch).and_return(epoch) }

        before { expect(source).to receive(:summary).and_return(summary) }

        before { expect(source).to receive(:group).and_return(group) }

        before { expect(source).to receive(:license).and_return(license) }

        before { expect(source).to receive(:url).and_return(url) }

        before { expect(source).to receive(:packager).and_return(packager) }

        before { expect(source).to receive(:vendor).and_return(vendor) }

        before { expect(source).to receive(:distribution).and_return(distribution) }

        before { expect(source).to receive(:description).and_return(description) }

        before { expect(source).to receive(:buildhost).and_return(buildhost) }

        before { expect(source).to receive(:filename).and_return(filename) }

        before { expect(source).to receive(:filesize).and_return(filesize) }

        before { expect(source).to receive(:md5).and_return(md5) }

        its(:keys) { should eq([:name, :version, :release, :epoch, :summary,
                                :group, :license, :url, :packager, :vendor,
                                :distribution, :description, :buildhost,
                                :filename, :filesize, :md5]) }

        its([:name]) { should eq(name) }

        its([:version]) { should eq(version) }

        its([:release]) { should eq(release) }

        its([:epoch]) { should eq(epoch) }

        its([:summary]) { should eq(summary) }

        its([:group]) { should eq(group) }

        its([:license]) { should eq(license) }

        its([:url]) { should eq(url) }

        its([:packager]) { should eq(packager) }

        its([:vendor]) { should eq(vendor) }

        its([:distribution]) { should eq(distribution) }

        its([:description]) { should eq(description) }

        its([:buildhost]) { should eq(buildhost) }

        its([:filename]) { should eq(filename) }

        its([:filesize]) { should eq(filesize) }

        its([:md5]) { should eq(md5) }
      end

      describe '#name' do
        it { expect(subject.name).to eq('glibc') }
      end

      describe '#version' do
        it { expect(subject.version).to eq('2.27') }
      end

      describe '#release' do
        it { expect(subject.release).to eq('19.fc28') }
      end

      describe '#epoch' do
        it { expect(subject.epoch).to eq(nil) }
      end

      describe '#summary' do
        it { expect(subject.summary).to eq('The GNU libc libraries') }
      end

      describe '#group' do
        it { expect(subject.group).to eq('Unspecified') }
      end

      describe '#license' do
        it { expect(subject.license).to eq('LGPLv2+ and LGPLv2+ with exceptions and GPLv2+') }
      end

      describe '#url' do
        it { expect(subject.url).to eq('http://www.gnu.org/software/glibc/') }
      end

      describe '#packager' do
        it { expect(subject.packager).to eq('Fedora Project') }
      end

      describe '#vendor' do
        it { expect(subject.vendor).to eq('Fedora Project') }
      end

      describe '#distribution' do
        it { expect(subject.distribution).to eq('Fedora Project') }
      end

      describe '#description' do
        it { expect(subject.description).to eq("""The glibc package contains standard libraries which are used by
multiple programs on the system. In order to save disk space and
memory, as well as to make upgrading easier, common system code is
kept in one place and shared between programs. This particular package
contains the most important sets of shared libraries: the standard C
library and the standard math library. Without these two libraries, a
Linux system will not function."""
        ) }
      end

      describe '#buildhost' do
        it { expect(subject.buildhost).to eq('buildhw-05.phx2.fedoraproject.org') }
      end

      describe '#filesize' do
        it { expect(subject.filesize).to eq(32_092_272) }
      end

      describe '#md5' do
        it { expect(subject.md5).to eq('9c8ee5a0c47cd137028fc4a03ef64347') }
      end

      describe '#filename' do
        it { expect(subject.filename).to eq('glibc-2.27-19.fc28.src.rpm') }
      end

      describe '#build_requires' do
        it 'size should be correct' do
          expect(subject.build_requires.size).to eq(29)
        end

        it 'parse dependecies without version and release' do
          expect(subject.build_requires.last).to eq(['zlib-devel'])
        end

        it 'parse dependecies with version and release' do
          expect(subject.build_requires.first).to eq(['audit-libs-devel', '>=', '1.1.3'])
        end
      end
    end
  end
end
