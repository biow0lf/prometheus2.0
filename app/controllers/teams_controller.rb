class TeamsController < ApplicationController
  def show
    @branch = Branch.where(:name => params[:branch], :vendor => "ALT Linux").first
    @team = Maintainer.where(:login => "@#{params[:id]}", :team => true).first
    @acls = Acl.where(:maintainer_id => @team.id, :branch_id => @branch.id).includes(:srpm => [:repocop_patch]).order('LOWER(srpms.name)')

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
