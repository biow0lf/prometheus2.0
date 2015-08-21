class TeamsController < ApplicationController
  def show
    @branch = Branch.find_by!(name: params[:branch])
    @branches = Branch.order('order_id')
    @team = MaintainerTeam.find_by!(login: "@#{ params[:id] }")
    @srpms_counter = @branch.srpms.where(name: Redis.current.smembers("#{ @branch.name }:maintainers:@#{ params[:id] }")).count
    @srpms = @branch.srpms.where(name: Redis.current.smembers("#{ @branch.name }:maintainers:@#{ params[:id] }")).
                           includes(:repocop_patch).
                           select('repocop, srpms.name, srpms.version, srpms.release, buildtime, srpms.url, summary').
                           order('LOWER(srpms.name)').decorate
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
