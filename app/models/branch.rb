class Branch < ActiveRecord::Base
  include Redis::Objects

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

  validates :name, presence: true

  validates :vendor, presence: true

  # validates :srpm_path, presence: true

  # validates :rpm_path, presence: true

  # Default value for counter: 0
  counter :counter

  after_destroy :destroy_counter

  def to_param
    name
  end

  def recount!
    counter.value = srpms.count
  end

  private

  def destroy_counter
    Redis.current.del("branch:#{ id }:counter")
  end
end
