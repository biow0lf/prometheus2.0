# frozen_string_literal: true

require 'rails_helper'

describe Package do
   it { should be_a(ApplicationRecord) }

   let(:branch) { create(:branch) }
   let(:srcfilename) { 'catpkt-1.0-alt5.src.rpm' }
   let(:group) { create(:group, branch: branch) }
   let(:rpm) { create(:rpm, :source, branch: branch, group: group, name: srcfilename) }
   let(:package) { rpm.package }
   let(:source_path) { create(:src_branch_path, path: Rails.root.join("spec/data"), branch: branch) }
   let(:branch_path) { create(:branch_path, arch: "i586", path: Rails.root.join("spec/data"), branch: branch, source_path_id: source_path.id) }

   describe 'Associations' do
      it { is_expected.to belong_to(:builder).class_name('Maintainer').inverse_of(:rpms).counter_cache(:srpms_count) }
      it { is_expected.to belong_to(:group) }

      it { is_expected.to have_many(:branches).through(:branch_paths) }
      it { is_expected.to have_many(:branch_paths).through(:rpms) }
      it { is_expected.to have_many(:rpms).inverse_of(:package).dependent(:destroy) }
   end

   describe 'Validation' do
      it { is_expected.to validate_presence_of(:group) }
      it { is_expected.to validate_presence_of(:md5) }
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:builder) }
      it { is_expected.to validate_presence_of(:buildtime) }
   end
end
