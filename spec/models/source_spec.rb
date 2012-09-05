require 'spec_helper'

describe Source do
  describe 'Associations' do
    it { should belong_to :branch }
    it { should belong_to :srpm }
  end

  describe 'Validation' do
    it { should validate_presence_of :branch }
    it { should validate_presence_of :srpm }
    it { should validate_presence_of :filename }
    it { should validate_presence_of :size }
  end
end
