# frozen_string_literal: true

require 'rails_helper'

describe Mirror do
  it { should be_a(ApplicationRecord) }

  it { should belong_to(:branch) }

  context 'Validation' do
    it { should validate_presence_of(:order_id) }

    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:uri) }

    it { should validate_presence_of(:protocol) }
  end
end
