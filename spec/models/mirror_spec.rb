# encoding: utf-8

require 'spec_helper'

describe Mirror do
  it { should belong_to :branch }

  it { should validate_presence_of :branch }
  it { should validate_presence_of :order_id }
  it { should validate_presence_of :name }
  it { should validate_presence_of :uri }
  it { should validate_presence_of :protocol }

  it { should have_db_index :branch_id }
end
