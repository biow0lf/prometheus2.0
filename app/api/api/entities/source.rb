module API
  module Entities
    class Source < Grape::Entity
      expose :srpm_id
      # t.binary   "source"
      expose :filename
      expose :size
      expose :created_at
      expose :updated_at
    end
  end
end
