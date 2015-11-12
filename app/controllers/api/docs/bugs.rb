module Api
  module Docs
    class Bugs
      # :nocov:
      include Swagger::Blocks

      swagger_path '/bugs/{bug_id}' do
        operation :get do
          key :description, 'Returns bug info for given bug_id'
          key :operationId, 'findBugById'
          key :tags, ['bugs']
          parameter do
            key :name, :bug_id
            key :in, :path
            key :description, 'ID of Bug'
            key :required, true
            key :type, :integer
            key :format, :int64
          end
        end
      end

      # :nocov:
    end
  end
end
