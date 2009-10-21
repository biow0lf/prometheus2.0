class TeamController < ApplicationController
  layout "default"

  def info
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }

    @team = Packager.find :first,
                          :conditions => {
                            :login => '@' + params[:name],
                            :team => true }
    if @team != nil
      @members = Team.find :all,
                           :conditions => {
                             :name => '@' + params[:name],
                             :branch => 'Sisyphus' }
      @leader = Team.find :first,
                          :conditions => {
                            :name => '@' + params[:name],
                            :branch => 'Sisyphus',
                            :leader => true }
    else
      render :action => "nosuchteam"
    end
  end

  def nosuchteam
  end
end
