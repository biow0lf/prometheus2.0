module Api
  module Docs
    class Branches
      # :nocov:
      include Swagger::Blocks

      swagger_path '/branches.json' do
        operation :get do
          key :description, 'Return list of all Branches'
          key :operationId, 'indexBranches'
          key :tags, ['branches']
        end
      end

      swagger_path '/branches/{id}.json' do
        operation :get do
          key :description, 'Return branch information'
          key :operationId, 'findBranchById'
          key :tags, ['branches']
          parameter do
            key :name, :id
            key :in, :path
            key :description, 'Branch ID. e.g. "1" for Sisyphus.'
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
