require 'spec_helper'

describe RepocopPatch do
  it { should validate_presence_of :name }
  it { should validate_presence_of :version }
  it { should validate_presence_of :release }
  it { should validate_presence_of :url }

  it { should have_db_index :name }
end
