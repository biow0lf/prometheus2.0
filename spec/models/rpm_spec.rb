require 'rails_helper'

RSpec.describe Rpm, type: :model do
   it { is_expected.to have_db_column(:branch_path_id) }
   it { is_expected.to have_db_column(:package_id) }
   it { is_expected.to have_db_column(:name) }
   it { is_expected.to have_db_column(:filename) }

   it { is_expected.to have_db_index(:branch_path_id) }
   it { is_expected.to have_db_index(:package_id) }
   it { is_expected.to have_db_index([:branch_path_id, :package_id]).unique(true) }
   it { is_expected.to have_db_index([:branch_path_id, :filename]).unique(true) }
   it { is_expected.to have_db_index(:name) }
   it { is_expected.to have_db_index(:filename) }

   it { is_expected.to belong_to(:branch_path) }
   it { is_expected.to belong_to(:package) }

   it { is_expected.to validate_presence_of(:branch_path) }
   it { is_expected.to validate_presence_of(:filename) }

   describe 'Callbacks' do
      it { is_expected.to callback(:fill_name_in).before(:save) }
   end
end
