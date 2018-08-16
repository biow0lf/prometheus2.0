# frozen_string_literal: true

class MaintainerProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @maintainer = Maintainer.find_by!(login: current_user.login)
  end

  def update
    @maintainer = Maintainer.find_by!(login: current_user.login)
    if @maintainer.update_attributes(maintainer_params)
      redirect_to maintainer_path(id: current_user.login, branch: 'sisyphus', locale: I18n.locale)
    else
      render text: 'Fail'
    end
  end

  private

  def maintainer_params
    params.permit(:info, :jabber, :time_zone, :location, :website)
  end
end
