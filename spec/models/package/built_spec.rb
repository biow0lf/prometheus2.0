# frozen_string_literal: true

require 'rails_helper'

describe Package::Built do
   let(:srpm) { create(:srpm, name: 'openbox') }
   let(:package) { srpm.package }
   let(:branch) { create(:branch, :with_paths, name: 'Sisyphus', vendor: 'ALT Linux') }
   let(:src_branch_path) { create(:src_branch_path, path: Rails.root.join("spec/data"), branch: branch) }
   let(:branch_path) { create(:branch_path, arch: 'x86_64', path: Rails.root.join("spec/data"), branch: branch) }

   context 'Associations' do
      it { is_expected.to belong_to(:src).class_name('Package::Src') }

      it { is_expected.to have_many(:provides).dependent(:destroy) }
      it { is_expected.to have_many(:requires).dependent(:destroy) }
      it { is_expected.to have_many(:obsoletes).dependent(:destroy) }
      it { is_expected.to have_many(:conflicts).dependent(:destroy) }
      it { is_expected.to have_many(:rpms).dependent(:destroy) }
      it { is_expected.to have_many(:branches) }
      it { is_expected.to have_many(:branch_paths) }
   end

   context 'is expected to import rpm' do
      before do
         Package::Src.import_all(src_branch_path.branch)
      end

      it 'all files' do
         expect { Package::Built.import_all(branch_path.branch) }.to change(Package, :count).by(2)
      end

      it 'one file' do
         file = Rails.root.join('spec/data/catpkt-1.0-alt5.i586.rpm')
         rpm = Rpm::Base.new(file)

         expect(rpm.name).to eq('catpkt')
         expect(rpm.arch).to eq('i586')
         expect(rpm.version).to eq('1.0')
         expect(rpm.release).to eq('alt5')
         expect(rpm.epoch).to eq(nil)
         expect(rpm.summary).to eq('FTS Packet Viewer')
         expect(rpm.group).to eq('Text tools')
         expect(rpm.license).to eq('BSD-like')
         expect(rpm.packager).to eq('Igor Zubkov <icesik@altlinux.org>')
         expect(rpm.vendor).to eq('ALT Linux Team')
         expect(rpm.distribution).to eq('ALT Linux')
         expect(rpm.description).to eq("Viewer for out/in-bound ftn-packets. Execution catpkt with no parameters\nwill give you help. There is no point address support, maybe, because, I'm\na bit lazy for all this stuff. You can use and modify it for free, the one\nthing I ask you for, is to e-mail me your diffs. Recoding from cp866 charset\nto koi8-r included by default (you can change this).")
         # TODO: add buildhost
         expect(rpm.buildtime).to eq(Time.at(1_349_449_262))
         expect(rpm.md5).to eq(`md5sum #{ file }`.split.first)
         expect(rpm.size).to eq(10_459)
         expect(rpm.filename).to eq("catpkt-1.0-alt5.i586.rpm")
         expect(rpm.file).to eq(file)
         expect(rpm.change_log.last).to match_array(["1118145600",
                                                     "Igor Zubkov <icesik@altlinux.ru> 1.0-alt1",
                                                     "- Initial build for Sisyphus."])

         expect { described_class.import(branch_path, rpm) }.to change(Package, :count).by(1)

         package = Package::Built.first

         expect(package.name).to eq('catpkt')
         expect(package.version).to eq('1.0')
         expect(package.release).to eq('alt5')
         expect(package.epoch).to be_nil
         expect(package.summary).to eq('FTS Packet Viewer')
         expect(package.group.full_name).to eq('Text tools')
         expect(package.groupname).to eq('Text tools')
         expect(package.license).to eq('BSD-like')
         expect(package.description).to eq("Viewer for out/in-bound ftn-packets. Execution catpkt with no parameters\nwill give you help. There is no point address support, maybe, because, I'm\na bit lazy for all this stuff. You can use and modify it for free, the one\nthing I ask you for, is to e-mail me your diffs. Recoding from cp866 charset\nto koi8-r included by default (you can change this).")
         expect(package.vendor).to eq('ALT Linux Team')
         expect(package.distribution).to eq('ALT Linux')
         expect(package.buildtime).to eq(Time.at(1_349_449_262))
         expect(package.size).to eq(10_459)
         expect(package.md5).to eq("774c4f7b191cd6117cb7686d8994eb29")
         expect(package.rpms.first.filename).to eq('catpkt-1.0-alt5.i586.rpm')
         expect(package.rpms.first.name).to eq('catpkt')
      end
   end
end
