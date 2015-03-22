require 'rails_helper'

describe Freshmeat do
  context 'Validation' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :version }
  end
end
