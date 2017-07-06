require 'rails_helper'

describe Obsolete do
  it { should be_a(ApplicationRecord) }

  it { should belong_to(:package) }

  it { should validate_presence_of(:name) }
end
