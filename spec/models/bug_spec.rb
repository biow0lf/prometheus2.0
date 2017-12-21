# frozen_string_literal: true

require 'rails_helper'

describe Bug do
  it { should be_a(ApplicationRecord) }

  describe 'Validations' do
    it { should validate_presence_of(:bug_id) }

    it { should validate_numericality_of(:bug_id).only_integer }
  end
end
