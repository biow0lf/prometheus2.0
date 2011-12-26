# encoding: utf-8

require 'spec_helper'

describe Mirror do
  describe 'Associations' do
    it { should belong_to :branch }
  end

  describe 'Validation' do
    it { should validate_presence_of :branch }
    it { should validate_presence_of :order_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :uri }
    it { should validate_presence_of :protocol }
  end

  it { should have_db_index :branch_id }
end
