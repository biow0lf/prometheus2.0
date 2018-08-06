# frozen_string_literal: true

require 'rails_helper'

module Extractor
  module RPM
    describe Binary do
      let(:file) { Rails.root.join('spec', 'fixtures', 'fedora', 'glibc-2.27-19.fc28', 'glibc-2.27-19.fc28.x86_64.rpm') }

      subject { Extractor::RPM::Binary.new(file) }

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

        let(:arch) { double }

        let(:sourcerpm) { double }

        let(:binary) { Extractor::RPM::Binary.new(file) }

        subject { binary.as_json }

        before { expect(binary).to receive(:name).and_return(name) }

        before { expect(binary).to receive(:version).and_return(version) }

        before { expect(binary).to receive(:release).and_return(release) }

        before { expect(binary).to receive(:epoch).and_return(epoch) }

        before { expect(binary).to receive(:summary).and_return(summary) }

        before { expect(binary).to receive(:group).and_return(group) }

        before { expect(binary).to receive(:license).and_return(license) }

        before { expect(binary).to receive(:url).and_return(url) }

        before { expect(binary).to receive(:packager).and_return(packager) }

        before { expect(binary).to receive(:vendor).and_return(vendor) }

        before { expect(binary).to receive(:distribution).and_return(distribution) }

        before { expect(binary).to receive(:description).and_return(description) }

        before { expect(binary).to receive(:buildhost).and_return(buildhost) }

        before { expect(binary).to receive(:filename).and_return(filename) }

        before { expect(binary).to receive(:filesize).and_return(filesize) }

        before { expect(binary).to receive(:md5).and_return(md5) }

        before { expect(binary).to receive(:arch).and_return(arch) }

        before { expect(binary).to receive(:sourcerpm).and_return(sourcerpm) }

        its(:keys) { should eq([:name, :version, :release, :epoch, :summary,
                                :group, :license, :url, :packager, :vendor,
                                :distribution, :description, :buildhost,
                                :filename, :filesize, :md5, :arch, :sourcerpm]) }

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

        its([:md5]) { should eq(md5) }

        its([:filesize]) { should eq(filesize) }

        its([:arch]) { should eq(arch) }

        its([:sourcerpm]) { should eq(sourcerpm) }
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
        it { expect(subject.filesize).to eq(3_792_068) }
      end

      describe '#md5' do
        it { expect(subject.md5).to eq('6ae9f8d4108c372a26c6c1853eb167e3') }
      end

      describe '#filename' do
        context 'with x86_64 file' do
          let(:file) { Rails.root.join('spec', 'fixtures', 'fedora', 'glibc-2.27-19.fc28', 'glibc-2.27-19.fc28.x86_64.rpm') }

          it { expect(subject.filename).to eq('glibc-2.27-19.fc28.x86_64.rpm') }
        end

        context 'with s390x file' do
          let(:file) { Rails.root.join('spec', 'fixtures', 'fedora', 'glibc-2.27-19.fc28', 'glibc-2.27-19.fc28.s390x.rpm') }

          it { expect(subject.filename).to eq('glibc-2.27-19.fc28.s390x.rpm') }
        end

        context 'with ppc64le file' do
          let(:file) { Rails.root.join('spec', 'fixtures', 'fedora', 'glibc-2.27-19.fc28', 'glibc-2.27-19.fc28.ppc64le.rpm') }

          it { expect(subject.filename).to eq('glibc-2.27-19.fc28.ppc64le.rpm') }
        end

        context 'with ppc64 file' do
          let(:file) { Rails.root.join('spec', 'fixtures', 'fedora', 'glibc-2.27-19.fc28', 'glibc-2.27-19.fc28.ppc64.rpm') }

          it { expect(subject.filename).to eq('glibc-2.27-19.fc28.ppc64.rpm') }
        end

        context 'with i686 file' do
          let(:file) { Rails.root.join('spec', 'fixtures', 'fedora', 'glibc-2.27-19.fc28', 'glibc-2.27-19.fc28.i686.rpm') }

          it { expect(subject.filename).to eq('glibc-2.27-19.fc28.i686.rpm') }
        end

        context 'with armv7hl file' do
          let(:file) { Rails.root.join('spec', 'fixtures', 'fedora', 'glibc-2.27-19.fc28', 'glibc-2.27-19.fc28.armv7hl.rpm') }

          it { expect(subject.filename).to eq('glibc-2.27-19.fc28.armv7hl.rpm') }
        end

        context 'with aarch64 file' do
          let(:file) { Rails.root.join('spec', 'fixtures', 'fedora', 'glibc-2.27-19.fc28', 'glibc-2.27-19.fc28.aarch64.rpm') }

          it { expect(subject.filename).to eq('glibc-2.27-19.fc28.aarch64.rpm') }
        end
      end

      describe '#arch' do
        context 'with x86_64 file' do
          let(:file) { Rails.root.join('spec', 'fixtures', 'fedora', 'glibc-2.27-19.fc28', 'glibc-2.27-19.fc28.x86_64.rpm') }

          it { expect(subject.arch).to eq('x86_64') }
        end

        context 'with s390x file' do
          let(:file) { Rails.root.join('spec', 'fixtures', 'fedora', 'glibc-2.27-19.fc28', 'glibc-2.27-19.fc28.s390x.rpm') }

          it { expect(subject.arch).to eq('s390x') }
        end

        context 'with ppc64le file' do
          let(:file) { Rails.root.join('spec', 'fixtures', 'fedora', 'glibc-2.27-19.fc28', 'glibc-2.27-19.fc28.ppc64le.rpm') }

          it { expect(subject.arch).to eq('ppc64le') }
        end

        context 'with ppc64 file' do
          let(:file) { Rails.root.join('spec', 'fixtures', 'fedora', 'glibc-2.27-19.fc28', 'glibc-2.27-19.fc28.ppc64.rpm') }

          it { expect(subject.arch).to eq('ppc64') }
        end

        context 'with i686 file' do
          let(:file) { Rails.root.join('spec', 'fixtures', 'fedora', 'glibc-2.27-19.fc28', 'glibc-2.27-19.fc28.i686.rpm') }

          it { expect(subject.arch).to eq('i686') }
        end

        context 'with armv7hl file' do
          let(:file) { Rails.root.join('spec', 'fixtures', 'fedora', 'glibc-2.27-19.fc28', 'glibc-2.27-19.fc28.armv7hl.rpm') }

          it { expect(subject.arch).to eq('armv7hl') }
        end

        context 'with aarch64 file' do
          let(:file) { Rails.root.join('spec', 'fixtures', 'fedora', 'glibc-2.27-19.fc28', 'glibc-2.27-19.fc28.aarch64.rpm') }

          it { expect(subject.arch).to eq('aarch64') }
        end
      end

      describe '#sourcerpm' do
        it { expect(subject.sourcerpm).to eq('glibc-2.27-19.fc28.src.rpm') }
      end

      describe '#requires' do
        it 'size should be correct' do
          expect(subject.requires.size).to eq(38)
        end

        it 'parse dependecies without version and release' do
          expect(subject.requires.last).to eq(['rtld(GNU_HASH)'])
        end

        it 'parse dependecies with version and release' do
          expect(subject.requires[4]).to eq(['glibc-langpack', '=', '2.27-19.fc28'])
        end
      end

      describe '#provides' do
        it 'size should be correct' do
          expect(subject.provides.size).to eq(95)
        end

        it 'parse dependecies without version and release' do
          expect(subject.provides.last).to eq(['rtld(GNU_HASH)'])
        end

        it 'parse dependecies with version and release' do
          expect(subject.provides[1]).to eq(['glibc', '=', '2.27-19.fc28'])
        end
      end

      describe '#obsoletes' do
        it 'size should be correct' do
          expect(subject.obsoletes.size).to eq(1)
        end

        it 'parse dependecies with version and release' do
          expect(subject.obsoletes.first).to eq(['glibc-profile', '<', '2.4'])
        end
      end

      describe '#conflicts' do
        it 'size should be correct' do
          expect(subject.conflicts.size).to eq(2)
        end

        it 'parse dependecies with version and release' do
          expect(subject.conflicts.first).to eq(['kernel', '<', '3.2'])
        end
      end
    end
  end
end
