# Class for handing Branches.

class Branch < ActiveRecord::Base
  include Redis::Objects

  validates :name, presence: true
  validates :vendor, presence: true

  has_many :srpms
  has_many :changelogs, through: :srpms
  has_many :packages
  has_many :groups
  has_many :teams
  has_many :mirrors
  has_many :patches
  has_many :ftbfs, class_name: 'Ftbfs'
  has_many :repocops
  has_many :repocop_patches

  counter :counter

  after_create :set_default_counter_value
  after_destroy :destroy_counter

  def to_param
    name
  end

  def set_default_counter_value
    Redis.current.set("branch:#{ id }:counter", 0)
  end

  def destroy_counter
    Redis.current.del("branch:#{ id }:counter")
  end

  def recount!
    Redis.current.set("branch:#{ id }:counter", srpms.count)
    self
  end
end
