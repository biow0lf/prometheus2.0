module API
  module Entities
    class Gear < Grape::Entity
      expose :srpm_id
      expose :maintainer_id
      expose :repo
      expose :lastchange
      expose :created_at
      expose :updated_at
    end
  end
end
