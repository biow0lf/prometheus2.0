require 'rails_helper'

describe API::Entities::Gear do
  subject { API::Entities::Gear }

  it { is_expected.to represent(:srpm_id) }
  it { is_expected.to represent(:maintainer_id) }
  it { is_expected.to represent(:maintainer_id) }
  it { is_expected.to represent(:repo) }
  it { is_expected.to represent(:lastchange) }
  it { is_expected.to represent(:created_at) }
  it { is_expected.to represent(:updated_at) }
end
