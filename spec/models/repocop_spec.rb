require 'spec_helper'

describe Repocop, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to :branch }

    skip { is_expected.to belong_to :srpm }
  end

  describe 'Validation' do
    it { is_expected.to validate_presence_of :branch }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :version }
    it { is_expected.to validate_presence_of :release }
    it { is_expected.to validate_presence_of :arch }
    it { is_expected.to validate_presence_of :srcname }
    it { is_expected.to validate_presence_of :srcversion }
    it { is_expected.to validate_presence_of :srcrel }
    it { is_expected.to validate_presence_of :testname }
  end

  it { is_expected.to have_db_index :srcname }
  it { is_expected.to have_db_index :srcrel }
  it { is_expected.to have_db_index :srcversion }

  it 'should import repocops from url' do
    page = `cat spec/data/prometheus2.sql`
    url = 'http://repocop.altlinux.org/pub/repocop/prometheus2/prometheus2.sql'
    FakeWeb.register_uri(:get, url, response: page)
    expect {
      Repocop.update_repocop
    }.to change { Repocop.count }.from(0).to(1)
  end
end
