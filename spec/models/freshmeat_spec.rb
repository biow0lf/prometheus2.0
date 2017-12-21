# frozen_string_literal: true

require 'rails_helper'

describe Freshmeat do
  it { should be_a(ApplicationRecord) }

  context 'Validation' do
    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:version) }
  end
end
