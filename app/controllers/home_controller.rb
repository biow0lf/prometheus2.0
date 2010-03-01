class HomeController < ApplicationController
#  caches_page :index, :project, :news, :security, :rss, :groups_list, :bygroup, :bytwogroup, :bythreegroup, :packagers_list

  def index
    @package_counter = Srpm.count_srpms_in_sisyphus
    @top15 = Packager.top15
  end

  def project
    @package_counter = Srpm.count_srpms_in_sisyphus
  end

  def news
    @package_counter = Srpm.count_srpms_in_sisyphus
  end

  def security
    @package_counter = Srpm.count_srpms_in_sisyphus
  end

  def rss
    @package_counter = Srpm.count_srpms_in_sisyphus
  end

  def stats
#    @packages_counter = Srpm.count
  end

  def top15
#    @top15 = Packager.find_by_sql("SELECT COUNT(srpms.name) AS counter, packagers.name AS name, packagers.login AS login FROM srpms, packagers WHERE packagers.id = srpms.packager_id AND packagers.team = false AND srpms.branch = 'Sisyphus' GROUP BY packagers.name, packagers.login ORDER BY 1 DESC LIMIT 1500")
    @top15 = Packager.find_by_sql("SELECT COUNT(acls.package) AS counter, packagers.name AS name, packagers.login AS login FROM acls, packagers WHERE packagers.login = acls.login AND packagers.team = false AND acls.branch = 'Sisyphus' GROUP BY packagers.name, packagers.login ORDER BY 1 DESC LIMIT 1500")
  end

  def search
    @package_counter = Srpm.count_srpms_in_sisyphus

    if params[:request].empty?
      redirect_to :action => "index"
    else
      @search = Srpm.name_or_summary_or_description_like_all(params[:search].to_s.split).branch_equals("Sisyphus").ascend_by_name
      @srpms, @srpms_count = @search.all, @search.count
    end
  end

  def groups_list
    @package_counter = Srpm.count_srpms_in_sisyphus
    @groups = Group.find_groups_in_sisyphus
  end

  def bygroup
    @package_counter = Srpm.count_srpms_in_sisyphus
    # TODO: branch can be not only Sisyphus!
    @branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => 'Sisyphus' }
    @group = Group.first :conditions => {
                           :name => params[:group],
                           :branch => @branch.name }
    @srpms = Srpm.all :conditions => {
                        :group => params[:group],
                        :branch => 'Sisyphus' }
  end

  def bytwogroup
    @package_counter = Srpm.count_srpms_in_sisyphus
    # TODO: branch can be not only Sisyphus!
    @branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => 'Sisyphus' }
    @group = Group.first :conditions => {
                           :name => params[:group] + '/' + params[:group2],
                           :branch => @branch.name }
    @srpms = Srpm.all :conditions => {
                        :group => params[:group] + '/' + params[:group2],
                        :branch => 'Sisyphus' }
  end

  def bythreegroup
    @package_counter = Srpm.count_srpms_in_sisyphus
    # TODO: branch can be not only Sisyphus!
    @branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => 'Sisyphus' }
    @group = Group.first :conditions => {
                           :name => params[:group] + '/' + params[:group2] + '/' + params[:group3],
                           :branch => @branch.name }
    @srpms = Srpm.all :conditions => {
                        :group => params[:group] + '/' + params[:group2] + '/' + params[:group3],
                        :branch => 'Sisyphus' }
  end

  def packagers_list
    @package_counter = Srpm.count_srpms_in_sisyphus
    @packagers = Packager.find_all_packagers_in_sisyphus
    @teams = Packager.find_all_teams_in_sisyphus
  end
end
