require 'open-uri'

class RepocopPatch < ActiveRecord::Base
  belongs_to :branch

  validates :branch, presence: true
  validates :name, presence: true
  validates :version, presence: true
  validates :release, presence: true
  validates :url, presence: true

  def self.update_repocop_patches
    ActiveRecord::Base.transaction do
      RepocopPatch.delete_all

      protocol = 'http'
      host     = 'repocop.altlinux.org'
      path     = '/pub/repocop/prometheus2/'
      file     = 'prometheus2-patches.sql'

      url = "#{protocol}://#{host}#{path}#{file}"
      file = open(URI.escape(url)).read

      file.each_line do |line|
        ActiveRecord::Base.connection.execute(line)
      end
    end
  end
end
