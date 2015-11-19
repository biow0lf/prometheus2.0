module Api
  module Docs
    class Maintainers
      # :nocov:
      include Swagger::Blocks

      swagger_schema :Maintainer do
        key :required, [:id, :name, :email, :login, :time_zone, :jabber,
                        :info, :website, :location, :created_at, :updated_at]
        property :id do
          key :type, :integer
          key :format, :int64
          key :description, 'Maintainer ID.'
        end
        property :name do
          key :type, :string
          key :description, 'Maintainer name'
        end
        property :email do
          key :type, :string
          key :description, 'Maintainer email'
        end
        property :login do
          key :type, :string
          key :description, 'Maintainer login'
        end
        property :time_zone do
          key :type, :string
          key :description, 'Maintainer time zone'
        end
        property :jabber do
          key :type, :string
          key :description, 'Maintainer jabber'
        end
        property :info do
          key :type, :string
          key :description, 'Maintainer info'
        end
        property :website do
          key :type, :string
          key :description, 'Maintainer website'
        end
        property :location do
          key :type, :string
          key :description, 'Maintainer location'
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
          response 200 do
            key :description, 'Response with maintainer.'
            schema do
              key :'$ref', :Maintainer
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
