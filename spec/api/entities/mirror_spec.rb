require 'rails_helper'

describe API::Entities::Mirror do
  subject { API::Entities::Mirror }

  it { is_expected.to represent(:branch_id) }
  it { is_expected.to represent(:order_id) }
  it { is_expected.to represent(:name) }
  it { is_expected.to represent(:country) }
  it { is_expected.to represent(:uri) }
  it { is_expected.to represent(:protocol) }
  it { is_expected.to represent(:created_at) }
  it { is_expected.to represent(:updated_at) }
end
