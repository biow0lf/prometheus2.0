module Api
  class PackageController < BaseController

    private

    def resource
      @packages ||= branch.packages.find_by!(name: params[:id])
    end
  end
end
