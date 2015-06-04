module API
  module Entities
    class Maintainer < Grape::Entity
      expose :name
      expose :email
      expose :login
      expose :time_zone
      expose :jabber
      expose :info
      expose :website
      expose :location
      expose :created_at
      expose :updated_at
    end
  end
end
