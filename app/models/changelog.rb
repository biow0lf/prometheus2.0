# frozen_string_literal: true

class Changelog < ApplicationRecord

  belongs_to :srpm

  validates :changelogtime, presence: true

  validates :changelogname, presence: true

  validates :changelogtext, presence: true

  def domain
    parse_changelogname[:domain]
  end

  def email
    parse_changelogname[:email]
  end

  def login
    parse_changelogname[:login]
  end

  def name
    parse_changelogname[:name]
  end

  def maintainer
    maintainer = Maintainer.find_or_initialize_by(login: login) do |m|
       m.email = email
       m.name = name
    end

    case domain
    when 'altlinux.org'
      maintainer
    when 'packages.altlinux.org'
      MaintainerTeam.find_or_initialize_by(login: maintainer.login) do |m|
         m.email = maintainer.email
         m.name = maintainer.name
      end
    end
  end

  def self.import(file, srpm)
    changelogs = `export LANG=C && rpm -qp --queryformat='[%{CHANGELOGTIME}\n**********\n%{CHANGELOGNAME}\n**********\n%{CHANGELOGTEXT}\n**********\n]' #{ file }`
    changelogs.force_encoding('binary')
    changelogs = changelogs.split("\n**********\n")
    while !changelogs.empty?
      record = changelogs.slice!(0..2)
      changelog = Changelog.new
      changelog.srpm_id = srpm.id
      changelog.changelogtime = record[0]
      changelog.changelogname = record[1]
      changelog.changelogtext = record[2]
      changelog.save!
    end
  end

  private

  def parse_changelogname
    @data ||= (
      if /(?<_name>.*)<(?<_login>.*)(@|\s*at\s*)(?<_domain>.*)(\.|\s*dot\s*)(org|com|ru|net)>/i =~ changelogname
        domain = "#{_domain.gsub(/\s*dot\s*/i, '.').strip}.org".downcase
        login = _login.strip.downcase

        @data = {
          name: _name.strip,
          login: login,
          email: "#{login}@#{domain}",
          domain: domain
        }
      else
        {}
      end
    )
  end
end
