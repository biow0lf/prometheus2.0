require 'rails_helper'

describe API::Entities::Repocop do
  subject { API::Entities::Repocop }

  it { is_expected.to represent(:branch_id) }
  it { is_expected.to represent(:name) }
  it { is_expected.to represent(:version) }
  it { is_expected.to represent(:release) }
  it { is_expected.to represent(:arch) }
  it { is_expected.to represent(:srcname) }
  it { is_expected.to represent(:srcversion) }
  it { is_expected.to represent(:srcrel) }
  it { is_expected.to represent(:testname) }
  it { is_expected.to represent(:status) }
  it { is_expected.to represent(:message) }
end
