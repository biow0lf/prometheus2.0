class MaintainersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit, :update]

  def edit
    @maintainer = Maintainer.where(:login => current_user.login).first
  end

  def update
    @maintainer = Maintainer.where(:login => current_user.login).first
    @maintainer.info = params[:info]
    @maintainer.jabber = params[:jabber]
    @maintainer.time_zone = params[:time_zone]
    @maintainer.location = params[:location]
    @maintainer.website = params[:website]

    if @maintainer.save
      redirect_to maintainer_path(:id => current_user.login, :locale => params[:locale])
      #redirect_to maintainers_path(:id => current_user.login, :locale => params[:locale])
    else
      render :text => 'Fail'
    end
  end

  def show
    @branch = Branch.where(:name => params[:branch], :vendor => "ALT Linux").first
    @maintainer = Maintainer.where(:login => params[:id].downcase, :team => false).first
    render(:status => 404, :action => "nosuchmaintainer") and return if @maintainer == nil
    @acls = Acl.where(:maintainer_id => @maintainer.id, :branch_id => @branch.id)
  end

  def srpms
    @branch = Branch.where(:name => params[:branch], :vendor => "ALT Linux").first
    @maintainer = Maintainer.where(:login => params[:id].downcase, :team => false).first
    render(:status => 404, :action => "nosuchmaintainer") and return if @maintainer == nil
    @acls = Acl.where(:maintainer_id => @maintainer.id, :branch_id => @branch.id).includes(:srpm => [:repocop_patch]).order('LOWER(srpms.name)')
  end

#  def acls
#    @branch = Branch.where(:name => params[:branch], :vendor => "ALT Linux").first
#    @maintainer = Maintainer.first :conditions => {
#                                     :login => params[:id].downcase,
#                                     :team => false }
#    @acls = Acl.all :conditions => {
#                      :login => params[:login],
#                      :branch_id => @branch.id }
#    if @maintainer == nil
#      render :status => 404, :action => "nosuchmaintainer"
#    end
#  end

  def gear
    @branch = Branch.where(:name => params[:branch], :vendor => "ALT Linux").first
    @maintainer = Maintainer.where(:login => params[:id].downcase, :team => false).first
    render(:status => 404, :action => "nosuchmaintainer") and return if @maintainer == nil    
    @gitrepos = Gitrepo.all :conditions => {
                              :maintainer_id => @maintainer.id },
                             :order => 'LOWER(repo)'
  end

  def bugs
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:id].downcase,
                                     :team => false }
    @bugs = Bug.all :conditions => {
                      :assigned_to => params[:id].downcase + '@altlinux.org',
                      :product => 'Sisyphus',
                      :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]},
                    :order => "bug_id DESC"
    @allbugs = Bug.all :conditions => {
                         :assigned_to => params[:id].downcase + '@altlinux.org',
                         :product => 'Sisyphus' },
                       :order => "bug_id DESC"
    if @maintainer == nil
      render :status => 404, :action => "nosuchmaintainer"
    end
  end

  def allbugs
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:id].downcase,
                                     :team => false }
    @bugs = Bug.all :conditions => {
                      :assigned_to => params[:id].downcase + '@altlinux.org',
                      :product => 'Sisyphus',
                      :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]},
                    :order => "bug_id DESC"
    @allbugs = Bug.all :conditions => {
                         :assigned_to => params[:id].downcase + '@altlinux.org',
                         :product => 'Sisyphus' },
                       :order => "bug_id DESC"
    if @maintainer == nil
      render :status => 404, :action => "nosuchmaintainer"
    end
  end

  def repocop
    @branch = Branch.where(:vendor => 'ALT Linux', :name => 'Sisyphus').first
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:id].downcase,
                                     :team => false },
                                   :include => [:srpms],
                                   :order => 'LOWER(srpms.name)'
    @srpms = @maintainer.srpms.find(:all, :conditions => { :branch_id => @branch.id }, :include => [:repocops])
    if @maintainer == nil
      render :status => 404, :action => "nosuchmaintainer"
    end
  end
end
