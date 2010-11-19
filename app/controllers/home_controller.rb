class HomeController < ApplicationController
#  caches_page :index, :project, :news, :security, :rss, :groups_list, :bygroup, :maintainers_list

#  caches_page :index

  def index
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    @top15 = Maintainer.top15
    @srpms = @branch.srpms.where("srpms.created_at > '2010-11-09 09:00:00'").includes(:group, :maintainer).order('srpms.created_at DESC').paginate(:page => params[:page], :per_page => 100)
  end

  def search
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    if params[:request].nil? and params[:search].nil?
      redirect_to :action => "index"
    else
      @search = Srpm.search(:name_or_summary_or_description_contains_all => params[:search].to_s.split).where(:branch_id => @branch.id).order("LOWER(name) ASC")
      @srpms, @srpms_count = @search.all, @search.count
    end
  end

  def maintainers_list
    @maintainers = Maintainer.find_all_maintainers_in_sisyphus
    @teams = Maintainer.find_all_teams_in_sisyphus
  end
end