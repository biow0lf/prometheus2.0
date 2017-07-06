require 'rails_helper'

describe Repocop do
  it { should be_a(ApplicationRecord) }

  it { should belong_to(:branch) }

  context 'Validation' do
    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:version) }

    it { should validate_presence_of(:release) }

    it { should validate_presence_of(:arch) }

    it { should validate_presence_of(:srcname) }

    it { should validate_presence_of(:srcversion) }

    it { should validate_presence_of(:srcrel) }

    it { should validate_presence_of(:testname) }
  end

  # it 'should import repocops from url' do
  #   page = File.read('spec/data/prometheus2.sql')
  #   url = 'http://repocop.altlinux.org/pub/repocop/prometheus2/prometheus2.sql'
  #   FakeWeb.register_uri(:get, url, response: page)
  #   expect { Repocop.update_repocop }.to change(Repocop, :count).by(1)
  # end
end
