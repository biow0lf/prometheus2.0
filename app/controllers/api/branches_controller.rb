module Api
  class BranchesController < ApplicationController
    include Swagger::Blocks

    swagger_path '/branches' do
      operation :get do
        key :description, 'Returns all branches info'
        key :operationId, 'findBranches'
      end
    end

    def index
      @branches = BranchDecorator.decorate_collection(Branch.order('id ASC'))
    end
  end
end
