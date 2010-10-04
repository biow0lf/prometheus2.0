class TeamController < ApplicationController
#  caches_page :info

  def info
    @branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => 'Sisyphus' }
    @team = Maintainer.first :conditions => {
                               :login => '@' + params[:name],
                               :team => true }
#    @acls = Acl.all :conditions => {
#                      :login => '@' + params[:name],
#                      :branch_id => @branch.id },
#                    :order => 'LOWER(package)'

    @acls = Acl.all :conditions => {
                      :maintainer_id => @team.id,
                      :branch_id => @branch.id }

    if @team != nil
      @leader = Team.find_by_sql(['SELECT maintainers.login, maintainers.name
                               FROM teams, maintainers, branches
                               WHERE maintainers.id = teams.maintainer_id
                               AND teams.name = ?
                               AND teams.branch_id = branches.id
                               AND branches.name = ?
                               AND leader = true
                               LIMIT 1', '@' + params[:name], @branch.name ])

      @members = Team.find_by_sql(['SELECT maintainers.login, maintainers.name
                               FROM teams, maintainers, branches
                               WHERE maintainers.id = teams.maintainer_id
                               AND teams.name = ?
                               AND teams.branch_id = branches.id
                               AND branches.name = ?
                               ORDER BY LOWER(maintainers.name)', '@' + params[:name], @branch.name ])
    else
      render :status => 404, :action => "nosuchteam"
    end
  end

  def nosuchteam
  end
end