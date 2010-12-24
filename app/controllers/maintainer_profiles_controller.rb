class MaintainerProfilesController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @maintainer = Maintainer.where(:login => current_user.login).first
  end

  def update
    @maintainer = Maintainer.where(:login => current_user.login).first
    @maintainer.info = params[:info]
    @maintainer.jabber = params[:jabber]
    @maintainer.time_zone = params[:time_zone]
    @maintainer.location = params[:location]
    @maintainer.website = params[:website]

    if @maintainer.save
      redirect_to maintainer_path(:id => current_user.login, :branch => 'Sisyphus', :locale => params[:locale])
    else
      render :text => 'Fail'
    end
  end
end
