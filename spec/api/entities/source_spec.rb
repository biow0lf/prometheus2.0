require 'rails_helper'

describe API::Entities::Source do
  subject { API::Entities::Source }

  it { is_expected.to represent(:srpm_id) }
  # t.binary   "source"
  it { is_expected.to represent(:filename) }
  it { is_expected.to represent(:size) }
  it { is_expected.to represent(:created_at) }
  it { is_expected.to represent(:updated_at) }
end
