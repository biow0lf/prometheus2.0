module Api
  module Docs
    class Branches
      # :nocov:
      include Swagger::Blocks

      swagger_path '/branches' do
        operation :get do
          key :description, 'Return list of all Branches'
          key :tags, ['branches']
          response 200 do
            key :description, 'Response with branches.'
            schema do
              key :type, :array
              items do
                key :'$ref', :OutputBranch
              end
            end
          end
        end
      end

      swagger_path '/branches/{id}' do
        operation :get do
          key :description, 'Return branch information'
          key :tags, ['branches']
          parameter do
            key :name, :id
            key :in, :path
            key :description, 'Branch ID. e.g. "1" for Sisyphus.'
            key :required, true
            key :type, :integer
            key :format, :int64
          end
          response 200 do
            key :description, 'Response with branch.'
            schema do
              key :'$ref', :OutputBranch
            end
          end
          response 404 do
            key :description, 'Branch not found.'
          end
        end
      end
      # :nocov:
    end
  end
end
