class PackagerController < ApplicationController
  layout "default"

  def info
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @packager = Packager.find :first,
                              :conditions => {
                                :login => params[:login].downcase,
                                :team => false }
    @acl = Acl.find :all,
                    :select => 'package',
                    :conditions => {
                      :login => params[:login],
                      :branch => 'Sisyphus' }
    if @packager == nil
      render :action => "nosuchpackager"
    end
  end

  def srpms
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @packager = Packager.find :first,
                              :conditions => { :login => params[:login].downcase }
    if @packager == nil
      render :action => "nosuchpackager"
    end
  end

  def gear
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @packager = Packager.find :first,
                              :conditions => { :login => params[:login].downcase }
    @gitrepos = Gitrepos.find :all,
                              :conditions => { :login => params[:login].downcase },
                              :order => 'package ASC'
    if @packager == nil
      render :action => "nosuchpackager"
    end
  end

  def bugs
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @packager = Packager.find :first,
                              :conditions => { :login => params[:login].downcase }
    @bugs = Bug.find :all,
                     :conditions => {
                       :assigned_to => params[:login].downcase + '@altlinux.org',
                       :product => 'Sisyphus',
                       :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]},
                     :order => "bug_id DESC"
    @allbugs = Bug.find :all,
                        :conditions => {
                          :assigned_to => params[:login].downcase + '@altlinux.org',
                          :product => 'Sisyphus' },
                        :order => "bug_id DESC"
    if @packager == nil
      render :action => "nosuchpackager"
    end
  end

  def allbugs
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @packager = Packager.find :first,
                              :conditions => { :login => params[:login].downcase }
    @bugs = Bug.find :all,
                     :conditions => {
                       :assigned_to => params[:login].downcase + '@altlinux.org',
                       :product => 'Sisyphus',
                       :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]},
                     :order => "bug_id DESC"
    @allbugs = Bug.find :all,
                        :conditions => {
                          :assigned_to => params[:login].downcase + '@altlinux.org',
                          :product => 'Sisyphus' },
                        :order => "bug_id DESC"
    if @packager == nil
      render :action => "nosuchpackager"
    end
  end

  def repocop
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @packager = Packager.find :first,
                              :conditions => { :login => params[:login].downcase }
    if @packager == nil
      render :action => "nosuchpackager"
    end
  end

  def nosuchpackager
  end

end
