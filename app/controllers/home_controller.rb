class HomeController < ApplicationController
#  caches_page :index, :project, :news, :security, :rss, :groups_list, :bygroup, :packagers_list

  def index
    @top15 = Maintainer.top15
  end

  def search
    branch = Branch.first :conditions => { :name => 'Sisyphus', :vendor => 'ALT Linux' }
    if params[:request].nil?
      redirect_to :action => "index"
    else
      @search = Srpm.name_or_summary_or_description_like_all(params[:search].to_s.split).branch_id_equals(branch.id).ascend_by_name
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
                               :branch_id => @branch.id }
    @srpms = Srpm.all :conditions => {
                        :group_id => @group.id,
                        :branch_id => @branch.id },
                      :order => 'LOWER(name)'
  end

  def maintainers_list
    @packagers = Maintainer.find_all_packagers_in_sisyphus
    @teams = Maintainer.find_all_teams_in_sisyphus
  end
end