require 'rails_helper'

RSpec.describe NamedSrpm, type: :model do
   it { is_expected.to have_db_column(:branch_path_id) }
   it { is_expected.to have_db_column(:srpm_id) }
   it { is_expected.to have_db_column(:name) }

   it { is_expected.to have_db_index(:branch_path_id) }
   it { is_expected.to have_db_index(:srpm_id) }
   it { is_expected.to have_db_index([:branch_path_id, :srpm_id]).unique(true) }
   it { is_expected.to have_db_index([:branch_path_id, :name]).unique(true) }
   it { is_expected.to have_db_index(:name) }

   it { is_expected.to belong_to(:branch_path) }
   it { is_expected.to belong_to(:srpm) }

   it { is_expected.to validate_presence_of(:branch_path) }
   it { is_expected.to validate_presence_of(:name) }

   describe 'Callbacks' do
      subject { create(:named_srpm) }

      it { should callback(:add_filename_to_cache).after(:save) }

      it { should callback(:increment_branch_counter).after(:create) }

      it { should callback(:decrement_branch_counter).after(:destroy) }

      it { should callback(:remove_filename_from_cache).after(:destroy) }

      it { should callback(:remove_acls_from_cache).after(:destroy) }

      it { should callback(:remove_leader_from_cache).after(:destroy) }
   end

   # private methods

   describe '#add_filename_to_cache' do
      subject { create(:named_srpm) }

      it { expect { subject.send(:add_filename_to_cache) }.not_to raise_error }
   end

   describe '#increment_branch_counter' do
      subject { create(:named_srpm) }

      specify { expect { subject.send(:increment_branch_counter) }.not_to raise_error }
   end

   describe '#decrement_branch_counter' do
      subject { create(:named_srpm) }

      specify { expect { subject.send(:decrement_branch_counter) }.not_to raise_error }
   end

   describe '#remove_filename_from_cache' do
      subject { create(:named_srpm) }

      specify { expect { subject.send(:remove_filename_from_cache) }.not_to raise_error }
   end

   describe '#remove_acls_from_cache' do
      subject { create(:named_srpm) }

      specify { expect { subject.send(:remove_acls_from_cache) }.not_to raise_error }
   end

   describe '#remove_leader_from_cache' do
      subject { create(:named_srpm) }

      specify { expect { subject.send(:remove_leader_from_cache) }.not_to raise_error }
   end
end
