require 'spec_helper'

describe RepocopPatch, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to :branch }
  end

  describe 'Validation' do
    it { is_expected.to validate_presence_of :branch }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :version }
    it { is_expected.to validate_presence_of :release }
    it { is_expected.to validate_presence_of :url }
  end

  it { is_expected.to have_db_index :name }

  it 'should import repocops patches list from url' do
    page = `cat spec/data/prometheus2-patches.sql`
    url = 'http://repocop.altlinux.org/pub/repocop/prometheus2/prometheus2-patches.sql'
    FakeWeb.register_uri(:get, url, response: page)
    expect { RepocopPatch.update_repocop_patches }
      .to change { RepocopPatch.count }.from(0).to(1)
  end
end
