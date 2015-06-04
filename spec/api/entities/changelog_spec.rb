require 'rails_helper'

describe API::Entities::Changelog do
  subject { API::Entities::Changelog }

  it { is_expected.to represent(:srpm_id) }
  it { is_expected.to represent(:changelogtime) }
  it { is_expected.to represent(:changelogname) }
  it { is_expected.to represent(:changelogtext) }
  it { is_expected.to represent(:created_at) }
  it { is_expected.to represent(:updated_at) }
end
