# frozen_string_literal: true

module Api
  class BaseController < ActionController::Base
    helper_method :collection, :resource, :branch

    rescue_from ActiveRecord::RecordNotFound do
      render nothing: true, status: :not_found
    end

    private

    def branch
      if params[:branch_id]
        @branch ||= Branch.find_by!(id: params[:branch_id])
      else
        @branch ||= Branch.find_by!(name: 'Sisyphus')
      end
    end
  end
end
