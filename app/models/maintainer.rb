# frozen_string_literal: true

class Maintainer < ApplicationRecord
  # include Redis::Objects

  validates :name, presence: true

  validates :email, presence: true

  validates :login, presence: true, uniqueness: true

  validates :name, immutable: true

  validates :email, immutable: true

  validates :login, immutable: true

  has_many :srpms, foreign_key: :builder_id, inverse_of: :builder, counter_cache: :srpms_count
  has_many :srpm_names, -> { select(:name).distinct }, through: :srpms, source: :named_srpms
  has_many :named_srpms, through: :srpms
  has_many :branches_paths, -> { distinct }, through: :named_srpms
  has_many :branches, -> { distinct}, through: :named_srpms
  has_many :branching_maintainers, dependent: :delete_all
  has_many :teams
  has_many :gears
  has_many :ftbfs, class_name: 'Ftbfs'

  scope :top, ->(limit) { order(srpms_count: :desc).limit(limit) }

  def to_param
    login
  end

  class << self
    def login_exists?(login)
      Maintainer.where(login: login.downcase).count > 0
    end

    def import(maintainer)
      name = maintainer.split('<')[0].chomp
      name.strip!
      email = maintainer.chop.split('<')[1].split('>')[0]
      email.downcase!
      email = FixMaintainerEmail.new(email).execute
      login = email.split('@')[0]
      domain = email.split('@')[1]
      if domain == 'altlinux.org'
        unless login_exists?(login)
          Maintainer.create(login: login, name: name, email: email)
        end
      elsif domain == 'packages.altlinux.org'
        unless MaintainerTeam.team_exists?(login)
          MaintainerTeam.create(login: login, name: name, email: email)
        end
      else
        raise 'Broken domain in Packager: tag'
      end
    end

    def import_from_changelogname(changelogname)
      pre_email = changelogname.chop.split('<')[1].split('>')[0].downcase
      email = FixMaintainerEmail.new(pre_email).execute

      Maintainer.find_or_create_by!(login: email.split('@')[0]) do |maintainer|
        maintainer.name = changelogname.split('<')[0].chomp.strip
        maintainer.email = email
      end
    end
  end
end
