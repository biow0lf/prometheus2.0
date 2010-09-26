class PackagerController < ApplicationController

  def info
    @branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => 'Sisyphus' }
    @packager = Packager.first :conditions => {
                                 :login => params[:login].downcase,
                                 :team => false }
    @acls = Acl.all :select => 'package',
                    :conditions => {
                      :login => params[:login],
                      :branch => @branch.name,
                      :vendor => @branch.vendor }
#                    :include => [:srpm]
    if @packager == nil
      render :status => 404, :action => "nosuchpackager"
    end
  end

  def srpms
    @branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => 'Sisyphus' }
    @packager = Packager.first :conditions => {
                                 :login => params[:login].downcase,
                                 :team => false },
                               :include => [:sisyphus]
#    @acls = Acl.all :conditions => {
#                      :login => params[:login],
#                      :branch => @branch.name,
#                      :vendor => @branch.vendor }
#                     :include => [:srpms]
    if @packager == nil
      render :status => 404, :action => "nosuchpackager"
    end
  end

  def acls
    @branch = Branch.first :conditions => { :urlname => 'Sisyphus' }
    @packager = Packager.first :conditions => {
                                 :login => params[:login].downcase,
                                 :team => false }
    @acls = Acl.all :conditions => {
                      :login => params[:login],
                      :branch_id => @branch.id }
#                     :include => [:srpm]
    if @packager == nil
      render :status => 404, :action => "nosuchpackager"
    end
  end

  def gear
    @packager = Packager.first :conditions => {
                                 :login => params[:login].downcase,
                                 :team => false }
    @gitrepos = Gitrepo.all :conditions => { :login => params[:login].downcase },
                             :order => 'LOWER(repo)'
    if @packager == nil
      render :status => 404, :action => "nosuchpackager"
    end
  end

  def bugs
    @packager = Packager.first :conditions => {
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
    if @packager == nil
      render :status => 404, :action => "nosuchpackager"
    end
  end

  def allbugs
    @packager = Packager.first :conditions => {
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
    if @packager == nil
      render :status => 404, :action => "nosuchpackager"
    end
  end

  def repocop
    @packager = Packager.first :conditions => {
                                 :login => params[:login].downcase,
                                 :team => false }
    if @packager == nil
      render :status => 404, :action => "nosuchpackager"
    end
  end

  def nosuchpackager
  end

end
