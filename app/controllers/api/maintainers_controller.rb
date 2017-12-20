# frozen_string_literal: true

module Api
  class MaintainersController < BaseController
    private

    def resource
      @maintainer ||= Maintainer.find_by!(login: params[:id])
    end

    def collection
      @maintainers ||= Maintainer.order(:login)
    end
  end
end
