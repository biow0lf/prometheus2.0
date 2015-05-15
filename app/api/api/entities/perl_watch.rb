module API
  module Entities
    class PerlWatch < Grape::Entity
      expose :name
      expose :version
      expose :path
      expose :created_at
      expose :updated_at
    end
  end
end
