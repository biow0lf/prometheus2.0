module API
  module Entities
    class Specfile < Grape::Entity
      expose :srpm_id
      # t.binary   "spec"
      expose :created_at
      expose :updated_at
    end
  end
end
