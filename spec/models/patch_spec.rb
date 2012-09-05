# encoding: utf-8

require 'spec_helper'

describe Patch do
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

  it { should have_db_index :branch_id }
  it { should have_db_index :srpm_id }
end
