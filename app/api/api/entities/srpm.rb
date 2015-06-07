module API
  module Entities
    class Srpm < Grape::Entity
      expose :id
      expose :branch_id
      expose :branch do |model|
        model.branch.name
      end
      expose :name
      expose :version
      expose :release
      expose :epoch
      expose :summary
      expose :license
      expose :groupname, as: :group
      expose :group_id
      expose :url
      expose :description
      expose :buildtime
      expose :filename
      expose :vendor
      expose :distribution
      expose :changelogname
      expose :changelogtext
      expose :changelogtime
      expose :md5
      expose :builder_id
      expose :size
      expose :repocop
      expose :created_at
      expose :updated_at
    end
  end
end
