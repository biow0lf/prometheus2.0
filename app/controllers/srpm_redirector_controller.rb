class SrpmRedirectorController < ApplicationController
  def index
    redirect_to srpm_path('Sisyphus', params[:name], locale: prefered_locale), status: 302
  end
end
