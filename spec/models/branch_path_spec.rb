require 'rails_helper'

RSpec.describe BranchPath, type: :model do
   it { is_expected.to have_db_column(:branch_id) }
   it { is_expected.to have_db_column(:arch) }
   it { is_expected.to have_db_column(:path) }

   it { is_expected.to have_db_index(:branch_id) }
   it { is_expected.to have_db_index(:arch) }
   it { is_expected.to have_db_index(:path) }
   it { is_expected.to have_db_index([:branch_id, :arch]).unique(true) }
   it { is_expected.to have_db_index([:arch, :path]).unique(true) }

   it { is_expected.to belong_to(:branch) }

   it { is_expected.to validate_presence_of(:branch) }
   it { is_expected.to validate_presence_of(:arch) }
   it { is_expected.to validate_presence_of(:path) }

   it { is_expected.to validate_inclusion_of(:arch).in_array(%w(i586 x86_64 noarch aarch64 mipsel armh)) }
end
