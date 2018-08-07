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
end
