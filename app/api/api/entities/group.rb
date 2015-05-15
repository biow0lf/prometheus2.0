module API
  module Entities
    class Group < Grape::Entity
      expose :id
      expose :branch_id
      expose :name
      expose :parent_id
      expose :lft
      expose :rgt
      expose :created_at
      expose :updated_at
    end
  end
end
