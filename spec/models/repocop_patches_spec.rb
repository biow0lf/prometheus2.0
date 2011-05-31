require 'spec_helper'

describe RepocopPatch do
  it { should validate_presence_of :name }
  it { should validate_presence_of :version }
  it { should validate_presence_of :release }
  it { should validate_presence_of :url }

  it { should have_db_index :name }

  it "should import repocop patches list from url" do
    URI.stub(:escape).and_return("spec/data/prometeus2-patches.sql")
    expect{RepocopPatch.update_repocop_patches}.to change{RepocopPatch.count}.from(0).to(1)
  end
end
