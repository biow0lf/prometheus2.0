class MaintainerController < ApplicationController
  def info
    @branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => 'Sisyphus' }
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:login].downcase,
                                     :team => false }
    @acls = Acl.all :conditions => {
                      :maintainer_id => @maintainer.id,
                      :branch_id => @branch.id }
    if @maintainer == nil
      render :status => 404, :action => "nosuchmaintainer"
    end
  end

  def srpms
    @branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => 'Sisyphus' }
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:login].downcase,
                                     :team => false }
    @acls = Acl.all :conditions => {
                      :login => params[:login].downcase,
                      :branch_id => @branch.id }
    if @maintainer == nil
      render :status => 404, :action => "nosuchmaintainer"
    end
  end

  def acls
    @branch = Branch.first :conditions => { :urlname => 'Sisyphus' }
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:login].downcase,
                                     :team => false }
    @acls = Acl.all :conditions => {
                      :login => params[:login],
                      :branch_id => @branch.id }
#                     :include => [:srpm]
    if @maintainer == nil
      render :status => 404, :action => "nosuchmaintainer"
    end
  end

  def gear
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:login].downcase,
                                     :team => false }
    @gitrepos = Gitrepo.all :conditions => { :login => params[:login].downcase },
                             :order => 'LOWER(repo)'
    if @maintainer == nil
      render :status => 404, :action => "nosuchmaintainer"
    end
  end

  def bugs
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:login].downcase,
                                     :team => false }
    @bugs = Bug.all :conditions => {
                      :assigned_to => params[:login].downcase + '@altlinux.org',
                      :product => 'Sisyphus',
                      :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]},
                    :order => "bug_id DESC"
    @allbugs = Bug.all :conditions => {
                         :assigned_to => params[:login].downcase + '@altlinux.org',
                         :product => 'Sisyphus' },
                       :order => "bug_id DESC"
    if @maintainer == nil
      render :status => 404, :action => "nosuchmaintainer"
    end
  end

  def allbugs
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:login].downcase,
                                     :team => false }
    @bugs = Bug.all :conditions => {
                      :assigned_to => params[:login].downcase + '@altlinux.org',
                      :product => 'Sisyphus',
                      :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]},
                    :order => "bug_id DESC"
    @allbugs = Bug.all :conditions => {
                         :assigned_to => params[:login].downcase + '@altlinux.org',
                         :product => 'Sisyphus' },
                       :order => "bug_id DESC"
    if @maintainer == nil
      render :status => 404, :action => "nosuchmaintainer"
    end
  end

  def repocop
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:login].downcase,
                                     :team => false }
    if @maintainer == nil
      render :status => 404, :action => "nosuchmaintainer"
    end
  end

  def nosuchmaintainer
  end
end