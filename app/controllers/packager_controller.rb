class PackagerController < ApplicationController
  layout "default"

  def info
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @packager = Packager.find :first,
                              :conditions => {
                                :login => params[:login].downcase,
                                :team => false }
    @leader = Leader.find :all,
                          :select => 'package',
                          :conditions => {
                            :login => params[:login].downcase,
                            :branch => 'Sisyphus' }
    @acl = Acl.find :all,
                    :select => 'package',
                    :conditions => {
                      :login => params[:login],
                      :branch => 'Sisyphus' }
  end

  def srpms
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @packager = Packager.find :first,
                              :conditions => { :login => params[:login].downcase }
    if @packager != nil
      @srpms = Srpm.find :all,
                         :conditions => {
                           :packager_id => @packager.id,
                           :branch => 'Sisyphus' },
                         :order => 'name ASC'
    end
  end

  def gear
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @packager = Packager.find :first,
                              :conditions => { :login => params[:login].downcase }
    @gitrepos = Gitrepos.find :all,
                              :conditions => { :login => params[:login].downcase },
                              :order => 'package ASC'
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
  end

  def repocop
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @packager = Packager.find :first,
                              :conditions => { :login => params[:login].downcase }

    if @packager != nil
      @srpms = Srpm.find :all,
                         :conditions => {
                           :packager_id => @packager.id,
                           :branch => 'Sisyphus' }
      @reports = Repocop.find :all,
                              :conditions => [ "srpms.packager_id = ? AND repocops.status <> 'ok' AND repocops.status <> 'skip' ", @packager.id ],
                              :joins => 'LEFT JOIN srpms ON repocops.srcname = srpms.name AND repocops.srcversion = srpms.version AND repocops.srcrel = srpms.release'
    end
  end

end
