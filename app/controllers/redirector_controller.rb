# frozen_string_literal: true

class RedirectorController < ApplicationController
  def index
    branch = Branch.find_by!(slug: 'sisyphus')
    package = branch.packages.includes(:srpm).find_by(name: params[:name])
    if package
      redirect_to srpm_path('sisyphus', package.srpm, locale: prefered_locale), status: 302
    else
      redirect_to srpm_path('sisyphus', params[:name], locale: prefered_locale), status: 302
    end
  end
end
