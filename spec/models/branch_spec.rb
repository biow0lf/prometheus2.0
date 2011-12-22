# encoding: utf-8

require 'spec_helper'

describe Branch do
  it { should validate_presence_of :name }
  it { should validate_presence_of :vendor }

  it { should have_many :acls }
  it { should have_many :srpms }
  it { should have_many :packages }
  it { should have_many :groups }
  it { should have_many :leaders }
  it { should have_many :teams }
  it { should have_many :mirrors }
  it { should have_many :patches }
  it { should have_many :ftbfs }
  it { should have_many :repocops }
  it { should have_many :repocop_patches }

  it "should return Branch.name on .to_param" do
    Branch.create!(name: 'Sisyphus', vendor: 'ALT Linux').to_param.should == 'Sisyphus'
  end
end
