module Api
  class MaintainersController < BaseController
    private

    def resource
      @maintainer ||= Maintainer.find_by!(login: params[:id])
    end
  end
end
