class MaintainerController < ApplicationController
  def info
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
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
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:login].downcase,
                                     :team => false }
    @acls = Acl.all :conditions => {
                      :maintainer_id => @maintainer.id,
                      :branch_id => @branch.id },
                    :include => [:srpm],
                    :order => 'LOWER(srpms.name)'
    if @maintainer == nil
      render :status => 404, :action => "nosuchmaintainer"
    end
  end

  def acls
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:login].downcase,
                                     :team => false }
    @acls = Acl.all :conditions => {
                      :login => params[:login],
                      :branch_id => @branch.id }
    if @maintainer == nil
      render :status => 404, :action => "nosuchmaintainer"
    end
  end

  def gear
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:login].downcase,
                                     :team => false }
    @gitrepos = Gitrepo.all :conditions => {
                              :maintainer_id => @maintainer.id },
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
    @branch = Branch.where(:vendor => 'ALT Linux', :name => 'Sisyphus').first
    @maintainer = Maintainer.first :conditions => {
                                     :login => params[:login].downcase,
                                     :team => false },
                                   :include => [:srpms],
                                   :order => 'LOWER(srpms.name)'
    @srpms = @maintainer.srpms.find(:all, :conditions => { :branch_id => @branch.id }, :include => [:repocops])
    if @maintainer == nil
      render :status => 404, :action => "nosuchmaintainer"
    end
  end
end