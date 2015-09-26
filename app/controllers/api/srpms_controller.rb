module Api
  class SrpmsController < BaseController
    private

    def parent
      if params[:branch_id]
        @branch ||= Branch.find_by!(id: params[:branch_id])
      else
        @branch ||= Branch.find_by!(name: 'Sisyphus')
      end
    end

    def resource
      @srpm ||= parent.srpms.where(name: params[:id]).includes(:branch).first!
    end
  end
end
