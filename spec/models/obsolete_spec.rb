# encoding: utf-8

require 'spec_helper'

describe Obsolete do
  it { should belong_to :package }

  it { should validate_presence_of :package }
  it { should validate_presence_of :name }

  it { should have_db_index :package_id }
end
