module Api
  class BranchesController < BaseController
    include Swagger::Blocks

    swagger_path '/branches' do
      operation :get do
        key :description, 'Return list of all Branches'
        key :operationId, 'indexBranches'
        key :tags, ['branches']
      end
    end

    swagger_path '/branches/{id}' do
      operation :get do
        key :description, 'Return branch information'
        key :operationId, 'showBranch'
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

    before_action :collection, only: :index

    private

    def resource
      @branch ||= Branch.find(params[:id])
    end

    def collection
      @branches ||= Branch.all
    end
  end
end
