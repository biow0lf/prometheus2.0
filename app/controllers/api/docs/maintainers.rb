module Api
  module Docs
    class Maintainers
      # :nocov:
      include Swagger::Blocks

      swagger_path '/maintainers' do
        operation :get do
          key :description, 'Returns maintainers info'
          key :tags, ['maintainers']
          response 200 do
            key :description, 'Response with maintainers.'
            schema do
              key :type, :array
              items do
                key :'$ref', :OutputMaintainer
              end
            end
          end
        end
      end

      swagger_path '/maintainers/{login}' do
        operation :get do
          key :description, 'Returns maintainer info'
          key :tags, ['maintainers']
          parameter do
            key :name, :login
            key :in, :path
            key :description, 'Maintainer login'
            key :required, true
            key :type, :string
          end
          response 200 do
            key :description, 'Response with maintainer.'
            schema do
              key :'$ref', :OutputMaintainer
            end
          end
          response 404 do
            key :description, 'Maintainer not found.'
          end
        end
      end
      # :nocov:
    end
  end
end
