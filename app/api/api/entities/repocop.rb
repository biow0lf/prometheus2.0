module API
  module Entities
    class Repocop < Grape::Entity
      expose :branch_id
      expose :name
      expose :version
      expose :release
      expose :arch
      expose :srcname
      expose :srcversion
      expose :srcrel
      expose :testname
      expose :status
      expose :message
    end
  end
end
