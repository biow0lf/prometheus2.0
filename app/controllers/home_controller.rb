class HomeController < ApplicationController
#  caches_page :index, :maintainers_list

  def index
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    @top15 = Maintainer.top15
    @srpms = @branch.srpms.where("srpms.created_at > '2010-11-09 09:00:00'").includes(:group, :maintainer).order('srpms.created_at DESC').paginate(:page => params[:page], :per_page => 50)
  end

  def maintainers_list
    @branch = Branch.where(:name => params[:branch], :vendor => 'ALT Linux').first
    @maintainers = Maintainer.find_all_maintainers_in_sisyphus
    @teams = Maintainer.find_all_teams_in_sisyphus
  end
end