require 'rails_helper'

describe API::Entities::Ftbfs do
  subject { API::Entities::Ftbfs }

  it { is_expected.to represent(:branch_id) }
  it { is_expected.to represent(:name) }
  it { is_expected.to represent(:epoch) }
  it { is_expected.to represent(:version) }
  it { is_expected.to represent(:release) }
  it { is_expected.to represent(:weeks) }
  it { is_expected.to represent(:arch) }
  it { is_expected.to represent(:maintainer_id) }
  it { is_expected.to represent(:created_at) }
  it { is_expected.to represent(:updated_at) }
end
