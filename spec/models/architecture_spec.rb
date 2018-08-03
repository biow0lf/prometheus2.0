# frozen_string_literal: true

require 'rails_helper'

describe Architecture do
  it { should be_an(ApplicationRecord) }

  it { should belong_to(:platform) }

  # it { should have_many(:sources).dependent(:destroy) }

  # it { should have_many(:binaries).through(:sources) }

  it { should validate_presence_of(:name) }
end
