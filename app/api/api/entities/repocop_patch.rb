module API
  module Entities
    class RepocopPatch < Grape::Entity
      expose :branch_id
      expose :name
      expose :version
      expose :release
      expose :url
    end
  end
end
