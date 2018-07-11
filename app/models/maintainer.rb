# frozen_string_literal: true

class Maintainer < ApplicationRecord
  # include Redis::Objects

  validates :name, presence: true

  validates :email, presence: true

  validates :login, presence: true, uniqueness: true

  validates :name, immutable: true

  validates :email, immutable: true

  validates :login, immutable: true

  has_many :teams

  has_many :gears

  has_many :ftbfs, class_name: 'Ftbfs'

  def to_param
    login
  end

  def domain
    email.split('@').last
  end

  def initialize options = {}
    if changelogname = options.delete(:changelogname)
      o = self.parse_changelogname(changelogname)
      options = options.merge(o) if o
    end

    super(options)
  end

  class << self
    def import_from_changelog(changelog)
      if maintainer = changelog.maintainer
        maintainer.save!
      else
        raise 'Broken domain in CHANGELOGNAME: tag'
      end

      maintainer
    end

    def import changelogname
      import_from_changelog(Changelog.new(changelogname: changelogname))
    end

    def top15(branch)
      maintainers = []

      Maintainer.select('login, name').each do |maintainer|
        m = [maintainer.login, maintainer.name, Redis.current.smembers("#{ branch.name }:maintainers:#{ maintainer.login }").count]
        maintainers << m
      end

      maintainers.sort! { |a, b| b[2] <=> a[2] }
      maintainers[0..14]
    end
  end
end
