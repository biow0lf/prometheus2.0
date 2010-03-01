class PackagerController < ApplicationController

  def info
    @package_counter = Srpm.count_srpms_in_sisyphus
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
      render :action => "nosuchpackager"
    end
  end

  def srpms
    @package_counter = Srpm.count_srpms_in_sisyphus
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
      render :action => "nosuchpackager"
    end
  end

  def acls
    @package_counter = Srpm.count_srpms_in_sisyphus
    @branch = Branch.first :conditions => { :urlname => 'Sisyphus' }
    @packager = Packager.first :conditions => {
                                 :login => params[:login].downcase,
                                 :team => false }
    @acls = Acl.all :conditions => {
                      :login => params[:login],
                      :branch_id => @branch.id }
#                     :include => [:srpm]
    if @packager == nil
      render :action => "nosuchpackager"
    end
  end

  def gear
    @package_counter = Srpm.count_srpms_in_sisyphus
    @packager = Packager.first :conditions => {
                                 :login => params[:login].downcase,
                                 :team => false }
    @gitrepos = Gitrepo.all :conditions => { :login => params[:login].downcase },
                             :order => 'repo ASC'
    if @packager == nil
      render :action => "nosuchpackager"
    end
  end

  def bugs
    @package_counter = Srpm.count_srpms_in_sisyphus
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
      render :action => "nosuchpackager"
    end
  end

  def allbugs
    @package_counter = Srpm.count_srpms_in_sisyphus
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
      render :action => "nosuchpackager"
    end
  end

  def repocop
    @package_counter = Srpm.count_srpms_in_sisyphus
    @packager = Packager.first :conditions => {
                                 :login => params[:login].downcase,
                                 :team => false }
    if @packager == nil
      render :action => "nosuchpackager"
    end
  end

  def nosuchpackager
  end

end
