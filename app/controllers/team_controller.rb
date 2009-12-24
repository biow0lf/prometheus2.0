class TeamController < ApplicationController
  layout "default"

#  caches_page :info

  def info
    @package_counter = Srpm.count_srpms_in_sisyphus
    @branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    @team = Packager.find :first,
                          :conditions => {
                            :login => '@' + params[:name],
                            :team => true }
    @acls = Acl.find :all,
                     :conditions => {
                       :login => '@' + params[:name],
                       :branch_id => @branch.id }

    if @team != nil
      @leader = Team.find_by_sql(['SELECT teams.login, packagers.name
                               FROM teams, packagers
                               WHERE packagers.login = teams.login
                               AND teams.name = ? AND teams.branch_id = ?
                               AND leader = true
                               LIMIT 1', '@' + params[:name], @branch.id ])

      @members = Team.find_by_sql(['SELECT teams.login, packagers.name
                               FROM teams, packagers
                               WHERE packagers.login = teams.login
                               AND teams.name = ?
                               AND teams.branch_id = ?', '@' + params[:name], @branch.id ])
    else
      render :action => "nosuchteam"
    end
  end

  def nosuchteam
  end
end
