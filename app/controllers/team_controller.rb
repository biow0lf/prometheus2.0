class TeamController < ApplicationController
  layout "default"

  def info
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }

    @team = Packager.find :first,
                          :conditions => {
                            :login => '@' + params[:name],
                            :team => true }
    if @team != nil
#      @members = Team.find_by_sql ["SELECT DISTINCT packagers.name, teams.login
#                                   FROM packagers, teams
#                                   WHERE teams.name = ?
#                                   AND teams.branch = 'Sisyphus'", '@' + params[:name]]

      @members = Team.find :all,
                           :conditions => {
                             :name => '@' + params[:name],
                             :branch => 'Sisyphus' }
      @leader = Team.find :first,
                          :conditions => {
                            :name => '@' + params[:name],
                            :branch => 'Sisyphus',
                            :leader => true }
      @srpms = Srpm.find :all,
                         :conditions => { :packager_id => @team.id },
                         :order => 'name ASC'
    end
  end

end
