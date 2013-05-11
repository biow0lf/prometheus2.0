class Branch < ActiveRecord::Base
  validates :name, presence: true
  validates :vendor, presence: true

  attr_accessible :name, :vendor, :path, :order_id

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

  def to_param
    name
  end
end
