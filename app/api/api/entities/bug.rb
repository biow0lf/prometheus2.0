module API
  module Entities
    class Bug < Grape::Entity
      expose :bug_id
      expose :bug_status
      expose :resolution
      expose :bug_severity
      expose :product
      expose :component
      expose :assigned_to
      expose :reporter
      expose :short_desc
      expose :created_at
      expose :updated_at
    end
  end
end
