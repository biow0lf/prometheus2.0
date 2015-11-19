module Api
  module Docs
    class Changelogs
      # :nocov:
      include Swagger::Blocks

      swagger_schema :Changelog do
        key :required, [:id, :srpm_id, :changelogtime, :changelogname,
                        :changelogext, :created_at, :updated_at]
        property :id do
          key :type, :integer
          key :format, :int64
          key :description, 'Changelog ID.'
        end
        property :srpm_id do
          key :type, :integer
          key :format, :int64
          key :description, 'Srpm ID.'
        end
        property :changelogtime do
          key :type, :string
          key :description, 'Changelog time'
        end
        property :changelogname do
          key :type, :string
          key :format, :binary
          key :description, 'Changelog name'
        end
        property :changelogext do
          key :type, :string
          key :format, :binary
          key :description, 'Changelog text'
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

      swagger_path '/srpms/{name}/changelogs' do
        operation :get do
          key :description, 'Returns srpm changelogs info for given name'
          key :operationId, 'findChangelogsForSrpm'
          key :tags, ['changelogs']
          parameter do
            key :name, :name
            key :in, :path
            key :description, 'Srpm name'
            key :required, true
            key :type, :string
          end
          parameter do
            key :name, :branch_id
            key :in, :query
            key :description, 'Branch id. Default: Sisyphus branch id, not name. E.g. 1.'
            key :type, :integer
            key :format, :int64
          end
          response 200 do
            key :description, 'Response with changelogs.'
            schema do
              key :type, :array
              items do
                key :'$ref', :Changelog
              end
            end
          end
          response 404 do
            key :description, 'Srpm and/or Branch not found.'
          end
        end
      end

      # :nocov:
    end
  end
end
