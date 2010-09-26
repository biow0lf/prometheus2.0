class HomeController < ApplicationController
#  caches_page :index, :project, :news, :security, :rss, :groups_list, :bygroup, :packagers_list

  def index
    @top15 = Packager.top15
  end

  def search
    if params[:request].empty?
      redirect_to :action => "index"
    else
      @search = Srpm.name_or_summary_or_description_like_all(params[:search].to_s.split).branch_equals("Sisyphus").ascend_by_name
      @srpms, @srpms_count = @search.all, @search.count
    end
  end

  def groups_list
    @groups = Group.find_groups_in_sisyphus
  end

  def bygroup
    # TODO: branch can be not only Sisyphus!
    @branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => 'Sisyphus' }
    
    groupname = params[:group]
    groupname = groupname + '/' + params[:group2] if !params[:group2].nil?
    groupname = groupname + '/' + params[:group3] if !params[:group3].nil?
    
    @group = Group.first :conditions => {
                               :name => groupname,
                               :branch => @branch.name }
    @srpms = Srpm.all :conditions => {
                        :group => groupname,
                        :branch => 'Sisyphus' },
                      :order => 'LOWER(name)'
  end

  def packagers_list
    @packagers = Packager.find_all_packagers_in_sisyphus
    @teams = Packager.find_all_teams_in_sisyphus
  end
end
