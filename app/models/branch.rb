# frozen_string_literal: true

class Branch < ApplicationRecord
  has_many :branch_paths
  has_many :rpms, through: :branch_paths
  has_many :packages, through: :branch_paths#, counter_cache: :srpms_count
  has_many :spkgs, through: :rpms, class_name: 'Package::Src', source: :package
  has_many :all_rpms, -> { unscope(where: :obsoleted_at) }, through: :branch_paths, class_name: :Rpm, source: :rpms
  has_many :all_spkgs, through: :all_rpms, class_name: 'Package::Src', source: :package
  has_many :rpm_names, -> { select(:name).distinct }, through: :branch_paths, source: :rpms
  has_many :srpm_filenames, -> { src.select(:filename).distinct }, through: :branch_paths, source: :rpms
  has_many :all_packages, -> { distinct }, through: :all_rpms, class_name: :Package, source: :package
  has_many :changelogs, through: :spkgs # rubocop:disable Rails/InverseOf (false positive)
  has_many :groups, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :mirrors, dependent: :destroy
#  has_many :patches, through: :packages # rubocop:disable Rails/InverseOf (false positive)
#  has_many :sources, through: :packages # rubocop:disable Rails/InverseOf (false positive)
  has_many :ftbfs, class_name: 'Ftbfs', dependent: :destroy
  has_many :repocops, dependent: :destroy
  has_many :repocop_patches, dependent: :destroy
  has_many :branching_maintainers, dependent: :delete_all
  has_many :maintainers, through: :branching_maintainers

  default_scope -> { order(:order_id) }

  scope :filled, -> { where.not(srpms_count: 0) }

  validates_presence_of :slug, :name, :vendor

  def to_param
    slug
  end

  def arches
    branch_paths.phys.active.select(:arch).distinct.pluck(:arch)
  end

  def acl_name
    name.downcase
  end

  def perpetual?
    slug == "sisyphus"
  end

  def imported_at
    branch_paths.src.active.select(:imported_at, "max(imported_at) as imported_at")
                            .group(:imported_at)
                            .pluck(:imported_at).first
  end
end
