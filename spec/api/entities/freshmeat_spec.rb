require 'rails_helper'

describe API::Entities::Freshmeat do
  subject { API::Entities::Freshmeat }

  it { is_expected.to represent(:name) }
  it { is_expected.to represent(:version) }
  it { is_expected.to represent(:created_at) }
  it { is_expected.to represent(:updated_at) }
end
