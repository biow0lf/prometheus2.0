# frozen_string_literal: true

require 'rails_helper'

describe Package::Src do
   let(:srpm) { create(:srpm, name: 'openbox') }
   let(:package) { srpm.package }
   let(:branch) { create(:branch, :with_paths, name: 'Sisyphus', vendor: 'ALT Linux') }
   let(:branch_path) { create(:src_branch_path, path: Rails.root.join("spec/data"), branch: branch) }

   before do
      # fix "uninitialized constant RSpec::Support::Differ"
      allow(File).to receive(:exist?).and_call_original
   end

   describe 'Associations' do
      it { is_expected.to have_one(:specfile).inverse_of(:package).dependent(:destroy) }
      it { is_expected.to have_one(:repocop_patch).with_primary_key('name').with_foreign_key('name').dependent(:destroy) }

      it { is_expected.to have_many(:packages).dependent(:destroy) }
      it { is_expected.to have_many(:changelogs).inverse_of(:package).dependent(:destroy) }
      it { is_expected.to have_many(:patches).inverse_of(:package).dependent(:destroy) }
      it { is_expected.to have_many(:sources).inverse_of(:package).dependent(:destroy) }
      it do
         is_expected.to have_many(:repocops)
            .order(name: :asc)
            .with_primary_key('name')
            .with_foreign_key('srcname')
            .dependent(:destroy)
      end
      it do
         is_expected.to have_many(:gears)
            .order(lastchange: :desc)
            .with_primary_key('name')
            .with_foreign_key('repo') # .dependent(:destroy)
      end

      it { is_expected.to_not have_db_column(:branch_id) }
      it { is_expected.to_not have_db_column(:filename) }
      it { is_expected.to_not have_db_column(:alias) }
   end

  describe 'Validation' do
    it { is_expected.to validate_presence_of(:groupname) }
    it { is_expected.to validate_presence_of(:md5) }
    it { is_expected.to validate_presence_of(:buildtime) }
  end

  # describe 'delegated methods' do
  #   it { should delegate_method(:name).to(:branch).with_prefix(true) }
  # end

  # set :acls

  # value :leader

   describe '#to_param' do
      subject { package }

      its(:to_param) { should eq('openbox') }
   end

   it 'is expected import srpm file' do
      file = Rails.root.join('spec/data/catpkt-1.0-alt5.src.rpm')
      rpm = Rpm::Base.new(file)

      expect(rpm.name).to eq('catpkt')
      expect(rpm.arch).to eq('src')
      expect(rpm.version).to eq('1.0')
      expect(rpm.release).to eq('alt5')
      expect(rpm.epoch).to eq(nil)
      expect(rpm.summary).to eq('FTS Packet Viewer')
      expect(rpm.group).to eq('Работа с текстами')
      expect(rpm.license).to eq('BSD-like')
      expect(rpm.packager).to eq('Igor Zubkov <icesik@altlinux.org>')
      expect(rpm.vendor).to eq('ALT Linux Team')
      expect(rpm.distribution).to eq('ALT Linux')
      expect(rpm.description).to eq("Viewer for out/in-bound ftn-packets. Execution catpkt with no parameters\nwill give you help. There is no point address support, maybe, because, I'm\na bit lazy for all this stuff. You can use and modify it for free, the one\nthing I ask you for, is to e-mail me your diffs. Recoding from cp866 charset\nto koi8-r included by default (you can change this).")
      # TODO: add buildhost
      expect(rpm.buildtime).to eq(Time.at(1_349_449_185))
      expect(rpm.md5).to eq(`md5sum #{ file }`.split.first)
      expect(rpm.size).to eq(14_216)
      expect(rpm.filename).to eq("catpkt-1.0-alt5.src.rpm")
      expect(rpm.file).to eq(file)
      expect(rpm.change_log.last).to match_array(["1118145600",
                                                  "Igor Zubkov <icesik@altlinux.ru> 1.0-alt1",
                                                  "- Initial build for Sisyphus."])

      expect { described_class.import(branch_path, rpm) }.to change(Package, :count).by(1)

      srpm = Package.first

      expect(srpm.name).to eq('catpkt')
      expect(srpm.version).to eq('1.0')
      expect(srpm.release).to eq('alt5')
      expect(srpm.epoch).to be_nil
      expect(srpm.summary).to eq('FTS Packet Viewer')
      expect(srpm.group.full_name).to eq('Работа с текстами')
      expect(srpm.groupname).to eq('Работа с текстами')
      expect(srpm.license).to eq('BSD-like')
      expect(srpm.description).to eq("Viewer for out/in-bound ftn-packets. Execution catpkt with no parameters\nwill give you help. There is no point address support, maybe, because, I'm\na bit lazy for all this stuff. You can use and modify it for free, the one\nthing I ask you for, is to e-mail me your diffs. Recoding from cp866 charset\nto koi8-r included by default (you can change this).")
      expect(srpm.vendor).to eq('ALT Linux Team')
      expect(srpm.distribution).to eq('ALT Linux')
      expect(srpm.buildtime).to eq(Time.at(1_349_449_185))
      expect(srpm.changelogs.last.changelogtime).to eq("1118145600")
      expect(srpm.changelogs.last.changelogname).to eq('Igor Zubkov <icesik@altlinux.ru> 1.0-alt1')
      expect(srpm.changelogs.last.changelogtext).to eq('- Initial build for Sisyphus.')
      expect(srpm.size).to eq(14_216)
      expect(srpm.md5).to eq("35f0f45bfbcdaf8754713fc1c97f8068")
      expect(srpm.rpms.first.filename).to eq('catpkt-1.0-alt5.src.rpm')
      expect(srpm.rpms.first.name).to eq('catpkt')

      expect(srpm.patches.first.filename).to eq("catpkt-1.0-alt-dont-strip.patch")
      expect(srpm.sources.first.filename).to eq("catpkt-1.0.tar.gz")
   end

   it 'should import all srpms from path' do
      expect { described_class.import_all(branch_path.branch) }.to change(Package, :count).by(2)
   end

   describe '#by_branch' do
      before do
         create_list(:srpm, 10, branch: branch)
         create(:branch)
         create_list(:srpm, 5)
      end

      it { expect(described_class.by_branch_slug(branch.slug).count).to eq(10) }
   end
end
