# frozen_string_literal: true

module Api
  module Docs
    class Bugs
      # :nocov:
      include Swagger::Blocks

      swagger_path '/bugs/{bug_id}' do
        operation :get do
          key :description, 'Returns bug info for given bug_id'
          key :tags, ['bugs']
          parameter do
            key :name, :bug_id
            key :in, :path
            key :description, 'ID of Bug'
            key :required, true
            key :type, :integer
            key :format, :int64
          end
          response 200 do
            key :description, 'Response with bug.'
            schema do
              key :'$ref', :OutputBug
            end
          end
          response 404 do
            key :description, 'Bug not found.'
          end
        end
      end
      # :nocov:
    end
  end
end
