# frozen_string_literal: true

require 'rails_helper'

describe Team do
  it { should be_a(ApplicationRecord) }

  context 'Associations' do
    it { should belong_to(:branch) }

    it { should belong_to(:maintainer) }
  end

  it { should validate_presence_of(:name) }
end
