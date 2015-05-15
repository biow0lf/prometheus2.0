module API
  module Entities
    class Freshmeat < Grape::Entity
      expose :name
      expose :version
      expose :created_at
      expose :updated_at
    end
  end
end
