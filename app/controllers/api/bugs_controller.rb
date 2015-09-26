module Api
  class BugsController < BaseController
    private

    def resource
      @bug ||= Bug.find_by!(bug_id: params[:id])
    end
  end
end
