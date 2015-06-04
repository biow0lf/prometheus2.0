module API
  module Entities
    class Changelog < Grape::Entity
      expose :srpm_id
      expose :changelogtime
      expose :changelogname
      expose :changelogtext
      expose :created_at
      expose :updated_at
    end
  end
end
