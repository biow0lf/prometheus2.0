class TeamController < ApplicationController
  layout "default"

  caches_page :info

  def info
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    @team = Packager.find :first,
                          :conditions => {
                            :login => '@' + params[:name],
                            :team => true }
    if @team != nil
#      @leader = Team.find :first,
#                          :conditions => {
#                            :name => '@' + params[:name],
#                            :branch_id => @branch.id,
#                            :leader => true },
#                          :joins => " LEFT JOIN packagers ON packagers.login = teams.login"

      @leader = Team.find_by_sql(['SELECT teams.login, packagers.name
                               FROM teams
                               LEFT JOIN packagers ON packagers.login = teams.login
                               WHERE teams.name = ? AND teams.branch_id = ?
                               AND leader = true', '@' + params[:name], @branch.id ])

      @members = Team.find_by_sql(['SELECT teams.login, packagers.name
                               FROM teams
                               LEFT JOIN packagers ON packagers.login = teams.login
                               WHERE teams.name = ? AND teams.branch_id = ?', '@' + params[:name], @branch.id ])
#      @members = Team.find :all,
#                           :conditions => {
#                             :name => '@' + params[:name],
#                             :branch_id => @branch.id },
#                           :joins => " LEFT JOIN packagers ON packagers.login = teams.login"
    else
      render :action => "nosuchteam"
    end
  end

  def nosuchteam
  end
end
