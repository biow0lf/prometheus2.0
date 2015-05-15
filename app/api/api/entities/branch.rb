module API
  module Entities
    class Branch < Grape::Entity
      expose :id
      expose :name
      expose :vendor
      expose :order_id
      expose :path
      expose :created_at
      expose :updated_at
    end
  end
end
