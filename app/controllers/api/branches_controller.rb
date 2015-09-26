module Api
  class BranchesController < BaseController
    private

    def resource
      @branch ||= Branch.find(params[:id])
    end

    def collection
      @branches ||= Branch.order(:id)
    end
  end
end
