# encoding: utf-8

require 'spec_helper'

describe Repocop do
  describe 'Associations' do
    it { should belong_to :branch }

    pending { should belong_to :srpm }
  end

  describe 'Validation' do
    it { should validate_presence_of :branch }
    it { should validate_presence_of :name }
    it { should validate_presence_of :version }
    it { should validate_presence_of :release }
    it { should validate_presence_of :arch }
    it { should validate_presence_of :srcname }
    it { should validate_presence_of :srcversion }
    it { should validate_presence_of :srcrel }
    it { should validate_presence_of :testname }
  end

  it { should have_db_index :srcname }
  it { should have_db_index :srcrel }
  it { should have_db_index :srcversion }

  it "should import repocops from url" do
    page = `cat spec/data/prometeus2.sql`
    FakeWeb.register_uri(:get,
                         "http://repocop.altlinux.org/pub/repocop/prometeus2/prometeus2.sql",
                         response: page)
    expect{
      Repocop.update_repocop
      }.to change{ Repocop.count }.from(0).to(1)
  end
end
