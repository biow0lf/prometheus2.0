require 'rails_helper'

describe API::Entities::Maintainer do
  subject { API::Entities::Maintainer }

  it { is_expected.to represent(:name) }
  it { is_expected.to represent(:email) }
  it { is_expected.to represent(:login) }
  it { is_expected.to represent(:time_zone) }
  it { is_expected.to represent(:jabber) }
  it { is_expected.to represent(:info) }
  it { is_expected.to represent(:website) }
  it { is_expected.to represent(:location) }
  it { is_expected.to represent(:created_at) }
  it { is_expected.to represent(:updated_at) }
end
