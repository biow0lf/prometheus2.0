# encoding: utf-8

class MaintainerProfilesController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @maintainer = Maintainer.where(login: current_user.login).first
  end

  def update
    @maintainer = Maintainer.where(login: current_user.login).first
    if @maintainer.update_attributes(maintainer_params)
      redirect_to maintainer_path(id: current_user.login, branch: 'Sisyphus', locale: I18n.locale)
    else
      render text: 'Fail'
    end
  end

private

  def maintainer_params
    params.permit(:info, :jabber, :time_zone, :location, :website)
  end
end
