class MaintainerTeam < ActiveRecord::Base
  include MaintainerHelper

  validates :name, presence: true
  validates :email, presence: true
  validates :login, presence: true, uniqueness: true

  validates :name, immutable: true
  validates :email, immutable: true
  validates :login, immutable: true

  # has_many :teams
  # has_many :gears
  # has_many :ftbfs, class_name: 'Ftbfs'

  def to_param
    login
  end

  def self.team_exists?(login)
    MaintainerTeam.where(login: login.downcase).count > 0
  end
end
