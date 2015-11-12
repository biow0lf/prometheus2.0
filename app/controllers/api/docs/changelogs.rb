module Api
  module Docs
    class Changelogs
      # :nocov:
      include Swagger::Blocks

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
        end
      end

      # :nocov:
    end
  end
end
