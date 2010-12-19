class TeamsController < ApplicationController
  def show
    @branch = Branch.find_by_name_and_vendor(params[:branch], 'ALT Linux')
    @team = Maintainer.first :conditions => {
                               :login => '@' + params[:id],
                               :team => true }
    @acls = Acl.all :conditions => {
                      :maintainer_id => @team.id,
                      :branch_id => @branch.id },
                    :include => [:srpm]
    if @team != nil
      @leader = Team.find_by_sql(["SELECT maintainers.login, maintainers.name
                               FROM teams, maintainers, branches
                               WHERE maintainers.id = teams.maintainer_id
                               AND teams.name = ?
                               AND teams.branch_id = branches.id
                               AND branches.name = ?
                               AND leader = 'true'
                               LIMIT 1", '@' + params[:id], @branch.name ])

      @members = Team.find_by_sql(["SELECT maintainers.login, maintainers.name
                               FROM teams, maintainers, branches
                               WHERE maintainers.id = teams.maintainer_id
                               AND teams.name = ?
                               AND teams.branch_id = branches.id
                               AND branches.name = ?
                               ORDER BY LOWER(maintainers.name)", '@' + params[:id], @branch.name ])
    else
      render :status => 404, :action => "nosuchteam"
    end
  end
end
