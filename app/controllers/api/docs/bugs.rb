module Api
  module Docs
    class Bugs
      # :nocov:
      include Swagger::Blocks

      swagger_schema :Bug do
        key :required, [:bug_id, :bug_status, :resolution, :bug_severity,
                        :product, :component, :assigned_to, :reporter,
                        :short_desc, :created_at, :updated_at]
        property :bug_id do
          key :type, :integer
          key :format, :int64
          key :description, 'Bug ID from bugzilla.altlinux.org'
        end
        property :bug_status do
          key :type, :string
          key :description, 'Bug status'
        end
        property :resolution do
          key :type, :string
          key :description, 'Bug resolution'
        end
        property :bug_severity do
          key :type, :string
          key :description, 'Bug severity'
        end
        property :product do
          key :type, :string
          key :description, 'Bug product'
        end
        property :component do
          key :type, :string
          key :description, 'Bug component'
        end
        property :assigned_to do
          key :type, :string
          key :description, 'Bug assigned to'
        end
        property :reporter do
          key :type, :string
          key :description, 'Bug reporter'
        end
        property :short_desc do
          key :type, :string
          key :description, 'Bug short description'
        end
        property :created_at do
          key :type, :string
          key :format, :'date-time'
          key :description, 'Created at in ISO8601 format'
        end
        property :updated_at do
          key :type, :string
          key :format, :'date-time'
          key :description, 'Updated at in ISO8601 format'
        end
      end

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
          response 200 do
            key :description, 'Response with bug.'
            schema do
              key :'$ref', :Branch
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
