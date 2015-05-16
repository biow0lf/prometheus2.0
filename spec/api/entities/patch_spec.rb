require 'rails_helper'

describe API::Entities::Patch do
  subject { API::Entities::Patch }

  it { is_expected.to represent(:srpm_id) }
  # t.binary   "patch"
  it { is_expected.to represent(:filename) }
  it { is_expected.to represent(:size) }
  it { is_expected.to represent(:created_at) }
  it { is_expected.to represent(:updated_at) }
end
