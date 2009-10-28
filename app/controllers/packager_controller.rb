class PackagerController < ApplicationController
  layout "default"

  def info
    @sisyphus = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    #@branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    @packager = Packager.find :first,
                              :conditions => {
                                :login => params[:login].downcase,
                                :team => false }
#    @acl = Acl.find :all,
#                    :select => 'package',
#                    :conditions => {
#                      :login => params[:login],
#                      :branch_id => @branch.id }
    if @packager == nil
      render :action => "nosuchpackager"
    end
  end

  def srpms
    @sisyphus = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
#    @branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    @packager = Packager.find :first,
                              :conditions => {
                                :login => params[:login].downcase,
                                :team => false }
    if @packager == nil
      render :action => "nosuchpackager"
    end
  end

  def gear
    @sisyphus = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    @packager = Packager.find :first,
                              :conditions => {
                                :login => params[:login].downcase,
                                :team => false }
    @gitrepos = Gitrepos.find :all,
                              :conditions => { :login => params[:login].downcase },
                              :order => 'package ASC'
    if @packager == nil
      render :action => "nosuchpackager"
    end
  end

  def bugs
    @sisyphus = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    @packager = Packager.find :first,
                              :conditions => {
                                :login => params[:login].downcase,
                                :team => false }
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
    @sisyphus = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    @packager = Packager.find :first,
                              :conditions => {
                                :login => params[:login].downcase,
                                :team => false }
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
    @sisyphus = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    @packager = Packager.find :first,
                              :conditions => {
                                :login => params[:login].downcase,
                                :team => false }
    if @packager == nil
      render :action => "nosuchpackager"
    end
  end

  def nosuchpackager
  end

end
