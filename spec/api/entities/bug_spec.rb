require 'rails_helper'

describe API::Entities::Bug do
  subject { API::Entities::Bug }

  it { is_expected.to represent(:bug_id) }
  it { is_expected.to represent(:bug_status) }
  it { is_expected.to represent(:resolution) }
  it { is_expected.to represent(:bug_severity) }
  it { is_expected.to represent(:product) }
  it { is_expected.to represent(:component) }
  it { is_expected.to represent(:assigned_to) }
  it { is_expected.to represent(:reporter) }
  it { is_expected.to represent(:short_desc) }
  it { is_expected.to represent(:created_at) }
  it { is_expected.to represent(:updated_at) }
end
