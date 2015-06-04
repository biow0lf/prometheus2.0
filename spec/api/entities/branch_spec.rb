require 'rails_helper'

describe API::Entities::Branch do
  subject { API::Entities::Branch }

  it { is_expected.to represent(:id) }
  it { is_expected.to represent(:name) }
  it { is_expected.to represent(:vendor) }
  it { is_expected.to represent(:order_id) }
  it { is_expected.to represent(:path) }
  it { is_expected.to represent(:created_at) }
  it { is_expected.to represent(:updated_at) }
end
