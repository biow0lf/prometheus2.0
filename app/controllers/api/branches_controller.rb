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

    before_action :collection, only: :index

    private

    def collection
      @branches ||= Branch.all
    end
  end
end
