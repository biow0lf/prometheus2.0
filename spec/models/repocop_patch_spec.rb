# frozen_string_literal: true

require 'rails_helper'

describe RepocopPatch do
  it { should be_a(ApplicationRecord) }

  it { should belong_to(:branch) }

  context 'Validation' do
    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:version) }

    it { should validate_presence_of(:release) }

    it { should validate_presence_of(:url) }
  end

  # it 'should import repocops patches list from url' do
  #   page = File.read('spec/data/prometheus2-patches.sql')
  #   url = 'http://repocop.altlinux.org/pub/repocop/prometheus2/prometheus2-patches.sql'
  #   FakeWeb.register_uri(:get, url, response: page)
  #   expect { RepocopPatch.update_repocop_patches }
  #     .to change(RepocopPatch, :count).by(1)
  # end
end
