module API
  module Entities
    class Mirror < Grape::Entity
      expose :branch_id
      expose :order_id
      expose :name
      expose :country
      expose :uri
      expose :protocol
      expose :created_at
      expose :updated_at
    end
  end
end
