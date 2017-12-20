# frozen_string_literal: true

module Api
  class SrpmsController < BaseController
    private

    def resource
      @srpm ||= branch.srpms.find_by!(name: params[:id])
    end

    def collection
      @collection ||= branch.srpms.order('LOWER(name)').page(params[:page])
    end
  end
end
