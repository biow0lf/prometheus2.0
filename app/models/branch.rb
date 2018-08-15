# frozen_string_literal: true

class Branch < ApplicationRecord
  include Redis::Objects

  has_many :branch_paths
  has_many :named_srpms, through: :branch_paths
  has_many :srpms, -> { distinct }, through: :named_srpms, counter_cache: :srpms_count
  has_many :changelogs, through: :srpms # rubocop:disable Rails/InverseOf (false positive)
  has_many :packages, through: :srpms # rubocop:disable Rails/InverseOf (false positive)
  has_many :groups, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :mirrors, dependent: :destroy
  has_many :patches, through: :srpms # rubocop:disable Rails/InverseOf (false positive)
  has_many :sources, through: :srpms # rubocop:disable Rails/InverseOf (false positive)
  has_many :ftbfs, class_name: 'Ftbfs', dependent: :destroy
  has_many :repocops, dependent: :destroy
  has_many :repocop_patches, dependent: :destroy

  scope :filled, -> { where.not(srpms_count: 0) }

  validates :name, presence: true
  validates :vendor, presence: true

  counter :counter

  after_create_commit :set_default_counter_value
  after_destroy_commit :destroy_counter

  def to_param
    name
  end

  def counter_value
    self.persisted? && counter.value || 0
  end

  def arches
    branch_paths.phys.active.select(:arch).distinct.pluck(:arch)
  end

  def acl_name
    name.downcase
  end

  def perpetual?
    name == "Sisyphus"
  end

  private

  def set_default_counter_value
    counter.value = 0
  end

  def destroy_counter
    Redis.current.del("branch:#{ id }:counter")
  end
end
