module Api
  class SrpmsController < ApplicationController
    def show
      if params[:branch_id]
        branch = Branch.find_by!(id: params[:branch_id])
      else
        branch = Branch.find_by!(name: 'Sisyphus')
      end
      @srpm = branch.srpms.where(name: params[:id]).includes(:branch).first!.decorate
    end
  end
end
