class TeamsController < ApplicationController
  def show
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @branches = Branch.order('order_id').all
    @team = MaintainerTeam.where(login: "@#{params[:id]}").first

    render(status: 404, action: 'nosuchteam') and return if @team == nil

    @srpms_counter = @branch.srpms.where(name: $redis.smembers("#{@branch.name}:maintainers:@#{params[:id]}")).count
    @srpms = @branch.srpms.where(name: $redis.smembers("#{@branch.name}:maintainers:@#{params[:id]}")).
                           includes(:repocop_patch).
                           select('repocop, name, version, release, buildtime, url, summary').
                           order('LOWER(srpms.name)').
                           decorate
    @leader = Team.find_by_sql(["SELECT maintainers.login, maintainers.name
                             FROM teams, maintainers, branches
                             WHERE maintainers.id = teams.maintainer_id
                             AND teams.name = ?
                             AND teams.branch_id = branches.id
                             AND branches.name = ?
                             AND leader = 'true'
                             LIMIT 1", "@#{params[:id]}", @branch.name ])
    @members = Team.find_by_sql(["SELECT maintainers.login, maintainers.name
                             FROM teams, maintainers, branches
                             WHERE maintainers.id = teams.maintainer_id
                             AND teams.name = ?
                             AND teams.branch_id = branches.id
                             AND branches.name = ?
                             ORDER BY LOWER(maintainers.name)", "@#{params[:id]}", @branch.name ])
  end
end
