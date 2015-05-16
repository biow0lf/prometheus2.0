require 'rails_helper'

describe API::Entities::Group do
  subject { API::Entities::Group }

  it { is_expected.to represent(:id) }
  it { is_expected.to represent(:branch_id) }
  it { is_expected.to represent(:name) }
  it { is_expected.to represent(:parent_id) }
  it { is_expected.to represent(:lft) }
  it { is_expected.to represent(:rgt) }
  it { is_expected.to represent(:created_at) }
  it { is_expected.to represent(:updated_at) }
end
