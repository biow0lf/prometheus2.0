require 'rails_helper'

describe API::Entities::Conflict do
  subject { API::Entities::Conflict }

  it { is_expected.to represent(:package_id) }
  it { is_expected.to represent(:name) }
  it { is_expected.to represent(:version) }
  it { is_expected.to represent(:release) }
  it { is_expected.to represent(:epoch) }
  it { is_expected.to represent(:flags) }
  it { is_expected.to represent(:created_at) }
  it { is_expected.to represent(:updated_at) }
end
