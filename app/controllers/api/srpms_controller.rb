module Api
  class SrpmsController < BaseController
    private

    def resource
      @srpm ||= branch.srpms.where(name: params[:id]).includes(:branch).first!
    end
  end
end
