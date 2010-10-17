class HomeController < ApplicationController
#  caches_page :index, :project, :news, :security, :rss, :groups_list, :bygroup, :maintainers_list

  def index
    @top15 = Maintainer.top15
  end

  def search
    branch = Branch.first(:conditions => { :name => 'Sisyphus', :vendor => 'ALT Linux' })
    if params[:request].nil?
      redirect_to :action => "index"
    else
      @search = Srpm.name_or_summary_or_description_like_all(params[:search].to_s.split).branch_id_equals(branch.id).ascend_by_name
      @srpms, @srpms_count = @search.all, @search.count
    end
  end

  def groups_list
    branch = Branch.first(:conditions => { :name => 'Sisyphus', :vendor => 'ALT Linux' })
    @groups = Group.all(:conditions => { :branch_id => branch.id, :parent_id => nil }, :order => 'LOWER(name)')
  end

  def bygroup
    # TODO: branch can be not only Sisyphus!
    @branch = Branch.first(:conditions => { :vendor => 'ALT Linux', :name => 'Sisyphus' })

    @group = Group.first(:conditions => {
                           :name => params[:group],
                           :branch_id => @branch.id,
                           :parent_id => nil })
    if !params[:group2].nil?
      @group = Group.first(:conditions => {
                             :name => params[:group2],
                             :branch_id => @branch.id,
                             :parent_id => @group.id })
      if !params[:group3].nil?
        @group = Group.first(:conditions => {
                               :name => params[:group3],
                               :branch_id => @branch.id,
                               :parent_id => @group.id })
      end
    end
    @srpms = Srpm.all(:conditions => {
                        :group_id => @group.id,
                        :branch_id => @branch.id },
                      :order => 'LOWER(name)')
  end

  def maintainers_list
    @maintainers = Maintainer.find_all_maintainers_in_sisyphus
    @teams = Maintainer.find_all_teams_in_sisyphus
  end
end