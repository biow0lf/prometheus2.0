module Api
  module Docs
    class Srpms
      # :nocov:
      include Swagger::Blocks

      swagger_path '/srpms/{name}' do
        operation :get do
          key :description, 'Returns srpm info for given name'
          key :operationId, 'findSrpmByName'
          key :tags, ['srpms']
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
