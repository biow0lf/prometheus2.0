# frozen_string_literal: true

require 'rails_helper'

describe Platform do
  it { should be_an(ApplicationRecord) }

  # it { should have_many(:architectures).dependent(:destroy) }
  #
  # it { should have_many(:sources).through(:architectures) }
  #
  # it { should have_many(:binaries).through(:sources) }

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:version) }
end
