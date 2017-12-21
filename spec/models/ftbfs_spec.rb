# frozen_string_literal: true

require 'rails_helper'

describe Ftbfs do
  it { should be_a(ApplicationRecord) }

  context 'Associations' do
    it { should belong_to(:branch) }

    it { should belong_to(:maintainer) }
  end

  context 'Validation' do
    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:version) }

    it { should validate_presence_of(:release) }

    it { should validate_presence_of(:weeks) }

    it { should validate_presence_of(:arch) }
  end
end
