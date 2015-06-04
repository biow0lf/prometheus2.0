require 'rails_helper'

describe API::Entities::PerlWatch do
  subject { API::Entities::PerlWatch }

  it { is_expected.to represent(:name) }
  it { is_expected.to represent(:version) }
  it { is_expected.to represent(:path) }
  it { is_expected.to represent(:created_at) }
  it { is_expected.to represent(:updated_at) }
end
