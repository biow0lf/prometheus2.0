# frozen_string_literal: true

require 'rails_helper'

describe Branch do
  it { is_expected.to be_a(ApplicationRecord) }

  it { is_expected.to have_many(:branch_paths) }
  it { is_expected.to have_many(:rpms).through(:branch_paths) }
  it { is_expected.to have_many(:packages).through(:branch_paths) }
  xit { is_expected.to have_many(:changelogs).through(:packages) }
  it { is_expected.to have_many(:groups).dependent(:destroy) }
  it { is_expected.to have_many(:teams).dependent(:destroy) }
  it { is_expected.to have_many(:mirrors).dependent(:destroy) }
  xit { is_expected.to have_many(:patches).through(:packages) }
  xit { is_expected.to have_many(:sources).through(:packages) }
  it { is_expected.to have_many(:ftbfs).class_name('Ftbfs').dependent(:destroy) }
  it { is_expected.to have_many(:repocops).dependent(:destroy) }
  it { is_expected.to have_many(:repocop_patches).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:vendor) }

  describe '#to_param' do
    subject { create(:branch, name: 'Sisyphus', slug: "sisyphus") }

    specify { expect(subject.to_param).to eq('sisyphus') }
  end

  describe '#arches' do
    subject { create(:branch, :with_paths, arches: %w(i586 x86_64 noarch aarch64 mipsel arm armh)) }

    specify { expect(subject.arches).to match_array(%w(i586 x86_64 aarch64 mipsel armh arm)) }
  end
end
