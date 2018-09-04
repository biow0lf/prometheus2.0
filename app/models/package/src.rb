# frozen_string_literal: true

class Package::Src < Package
   has_one :repocop_patch, primary_key: 'name', foreign_key: 'name', dependent: :destroy
   has_one :specfile, foreign_key: :package_id, inverse_of: :package, dependent: :destroy

   has_many :packages, foreign_key: :src_id, class_name: 'Package::Built', dependent: :destroy
   has_many :changelogs, foreign_key: :package_id, inverse_of: :package, dependent: :destroy
   has_many :patches, foreign_key: :package_id, inverse_of: :package, dependent: :destroy
   has_many :sources, foreign_key: :package_id, inverse_of: :package, dependent: :destroy
   has_many :repocops, -> { order(name: :asc) },
                       primary_key: :name,
                       foreign_key: :srcname,
                       dependent: :destroy
   has_many :gears, -> { order(lastchange: :desc) },
                    primary_key: :name,
                    foreign_key: :repo

   scope :top_rebuilds_after, ->(date) do
      where("buildtime > ?", date)
         .select(:name, 'count(packages.name) as id')
         .group(:name)
         .having('count(packages.name) > 5')
         .order('id DESC', :name)
   end

   def contributors
      logins = []
      changelogs.each do |changelog|
         next unless changelog.email
         logins << changelog.login
      end
      Maintainer.where(login: logins.sort.uniq).order(:name)
   end

   def acls
      return unless Redis.current.exists("#{ branch.name }:#{ name }:acls")
      Maintainer.where(login: Redis.current.smembers("#{ branch.name }:#{ name }:acls")).order(:name).select('login').map(&:login).join(',')
   end

   class ActiveRecord_Relation
      def page value
         @page = (value || 1).to_i
         @total_count = self[0] && self.size || 0

         self.class_eval do
            def total_count
               @total_count
            end

            def total_pages
               (@total_count + 24) / 25
            end

            def current_page
               @page
            end

            def each &block
               range = ((@page - 1) * 25...@page * 25)
               self[range].each(&block)
            end
         end

         self
      end
   end
end
