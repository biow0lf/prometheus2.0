module Api
  class PackagesController < BaseController
    private

    def branch
      if params[:branch_id]
        @branch ||= Branch.find_by!(id: params[:branch_id])
      else
        @branch ||= Branch.find_by!(name: 'Sisyphus')
      end
    end

    def parent
      @srpm ||= branch.srpms.find_by!(name: params[:srpm_id])
    end

    def collection
      @packages ||= parent.packages
    end
  end
end
