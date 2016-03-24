module Api
  class SrpmsController < BaseController
    private

    def resource
      @srpm ||= branch.srpms.find_by!(name: params[:id])
    end
  end
end
