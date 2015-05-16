require 'rails_helper'

describe API::Entities::Srpm do
  subject { API::Entities::Srpm }

  it { is_expected.to represent(:id) }
  it { is_expected.to represent(:branch_id) }
  it { is_expected.to represent(:name) }
  it { is_expected.to represent(:version) }
  it { is_expected.to represent(:release) }
  it { is_expected.to represent(:epoch) }
  it { is_expected.to represent(:summary) }
  it { is_expected.to represent(:license) }
  it { is_expected.to represent(:groupname).as(:group) }
  it { is_expected.to represent(:group_id) }
  it { is_expected.to represent(:url) }
  it { is_expected.to represent(:description) }
  it { is_expected.to represent(:buildtime) }
  it { is_expected.to represent(:filename) }
  it { is_expected.to represent(:vendor) }
  it { is_expected.to represent(:distribution) }
  it { is_expected.to represent(:changelogname) }
  it { is_expected.to represent(:changelogtext) }
  it { is_expected.to represent(:changelogtime) }
  it { is_expected.to represent(:md5) }
  it { is_expected.to represent(:builder_id) }
  it { is_expected.to represent(:size) }
  it { is_expected.to represent(:repocop) }
  it { is_expected.to represent(:created_at) }
  it { is_expected.to represent(:updated_at) }
end
