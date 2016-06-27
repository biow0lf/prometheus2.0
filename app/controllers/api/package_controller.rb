module Api
  class PackageController < BaseController
    private

    def resource
      @packages ||= branch.packages.where(name: params[:id])
    end
  end
end
