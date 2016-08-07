class Branch < ApplicationRecord
  include Redis::Objects

  validates :name, presence: true

  validates :vendor, presence: true

  #
  # TODO: enable counter cache for me!!!
  #
  has_many :srpms

  has_many :changelogs, through: :srpms

  has_many :packages, through: :srpms

  has_many :groups

  has_many :teams

  has_many :mirrors

  has_many :patches, through: :srpms

  has_many :sources, through: :srpms

  has_many :ftbfs, class_name: 'Ftbfs'

  has_many :repocops

  has_many :repocop_patches

  counter :counter

  after_create :set_default_counter_value

  after_destroy :destroy_counter

  def to_param
    name
  end

  private

  def set_default_counter_value
    counter.value = 0
  end

  def destroy_counter
    Redis.current.del("branch:#{ id }:counter")
  end
end
