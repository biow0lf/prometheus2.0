# frozen_string_literal: true

class SrpmRedirectorController < ApplicationController
  def index
    redirect_to srpm_path('sisyphus', params[:name], locale: prefered_locale), status: 302
  end
end
