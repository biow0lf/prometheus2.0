module API
  module Entities
    class Ftbfs < Grape::Entity
      expose :branch_id
      expose :name
      expose :epoch
      expose :version
      expose :release
      expose :weeks
      expose :arch
      expose :maintainer_id
      expose :created_at
      expose :updated_at
    end
  end
end
