require 'rails_helper'

describe API::Entities::Specfile do
  subject { API::Entities::Specfile }

  it { is_expected.to represent(:srpm_id) }
  # t.binary   "spec"
  it { is_expected.to represent(:created_at) }
  it { is_expected.to represent(:updated_at) }
end
