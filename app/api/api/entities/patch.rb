module API
  module Entities
    class Patch < Grape::Entity
      expose :srpm_id
      # t.binary   "patch"
      expose :filename
      expose :size
      expose :created_at
      expose :updated_at
    end
  end
end
