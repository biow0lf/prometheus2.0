module Api
  class ChangelogsController < BaseController
    private

    def parent
      @srpm ||= branch.srpms.find_by!(name: params[:srpm_id])
    end

    def collection
      @changelogs ||= parent.changelogs
    end
  end
end
