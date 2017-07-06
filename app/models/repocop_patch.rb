require 'open-uri'

class RepocopPatch < ApplicationRecord
  belongs_to :branch

  validates :name, presence: true

  validates :version, presence: true

  validates :release, presence: true

  validates :url, presence: true

  class << self
    def update_repocop_patches
      ActiveRecord::Base.transaction do
        RepocopPatch.delete_all

        url = 'http://repocop.altlinux.org/pub/repocop/prometheus2/prometheus2-patches.sql'
        file = open(URI.escape(url)).read

        file.each_line do |line|
          ActiveRecord::Base.connection.execute(line)
        end
      end
    end
  end
end
