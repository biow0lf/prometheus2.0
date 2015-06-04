require 'rails_helper'

describe API::Entities::RepocopPatch do
  subject { API::Entities::RepocopPatch }

  it { is_expected.to represent(:branch_id) }
  it { is_expected.to represent(:name) }
  it { is_expected.to represent(:version) }
  it { is_expected.to represent(:release) }
  it { is_expected.to represent(:url) }
end
