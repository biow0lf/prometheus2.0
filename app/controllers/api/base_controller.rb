module Api
  class BaseController < ActionController::Base
    helper_method :collection, :resource

    rescue_from ActiveRecord::RecordNotFound do
      render nothing: true, status: :not_found
    end
  end
end
