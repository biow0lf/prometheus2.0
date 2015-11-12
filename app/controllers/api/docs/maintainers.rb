module Api
  module Docs
    class Maintainers
      # :nocov:
      include Swagger::Blocks

      swagger_path '/maintainers/{login}' do
        operation :get do
          key :description, 'Returns maintainer info'
          key :operationId, 'findMaintainerByLogin'
          key :tags, ['maintainers']
          parameter do
            key :name, :login
            key :in, :path
            key :description, 'Maintainer login'
            key :required, true
            key :type, :string
          end
        end
      end

      # :nocov:
    end
  end
end
