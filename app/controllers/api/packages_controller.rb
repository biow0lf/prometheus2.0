# frozen_string_literal: true

module Api
  class PackagesController < BaseController
    private

    def parent
      @srpm ||= branch.srpms.find_by!(name: params[:srpm_id])
    end

    def collection
      @packages ||= parent.packages
    end
  end
end
