class TeamController < ApplicationController
#  caches_page :info

  def info
    @package_counter = Srpm.count_srpms_in_sisyphus
    @branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => 'Sisyphus' }
    @team = Packager.first :conditions => {
                             :login => '@' + params[:name],
                             :team => true }
    @acls = Acl.all :conditions => {
                      :login => '@' + params[:name],
                      :branch => @branch.name }

    if @team != nil
      @leader = Team.find_by_sql(['SELECT teams.login, packagers.name
                               FROM teams, packagers
                               WHERE packagers.login = teams.login
                               AND teams.name = ? AND teams.branch = ?
                               AND leader = true
                               LIMIT 1', '@' + params[:name], @branch.name ])

      @members = Team.find_by_sql(['SELECT teams.login, packagers.name
                               FROM teams, packagers
                               WHERE packagers.login = teams.login
                               AND teams.name = ?
                               AND teams.branch = ?', '@' + params[:name], @branch.name ])
    else
      render :action => "nosuchteam"
    end
  end

  def nosuchteam
  end
end
