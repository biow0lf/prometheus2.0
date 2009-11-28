class SrpmController < ApplicationController
  layout "default"

#  caches_page :main, :changelog, :rawspec, :patches, :sources, :download, :gear, :bugs, :allbugs, :repocop

  def main
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @branch = Branch.find :first, :conditions => { :urlname => params[:branch] }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch => @branch.urlname },
                      :include => [:acls, :group]

    if @srpm != nil
      @allsrpms = Srpm.find :all,
                            :conditions => { :name => params[:name] }
#                            :order => 'branch ASC'

#      if params[:branch] == 'Sisyphus' or params[:branch] == '5.1'
      if params[:branch] == 'Sisyphus'
        @packages = Package.find :all,
                                 :conditions => {
                                   :branch_id => @branch.id,
                                   :sourcepackage => @srpm.filename,
                                   :arch => ["noarch", "i586"] },
                                 :order => 'name ASC'
        @leader = Leader.find :first,
                              :conditions => {
                                :branch_id => @branch.id,
                                :package => params[:name] }
        @packager = Packager.find :first,
                                  :conditions => { :login => @leader.login }
      elsif params[:branch] == '5.1' or params[:branch] == 'Platform5'
        @packages = Package.find :all,
                                 :conditions => {
                                   :branch_id => @branch.id,
                                   :sourcepackage => @srpm.filename,
                                   :arch => ["noarch", "i586"] },
                                 :order => 'name ASC'
      end
    else
      render :action => "nosuchpackage"
    end
  end

  def changelog
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @branch = Branch.find :first, :conditions => { :urlname => params[:branch] }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch => @branch.urlname }
    #@changelogs = Changelog.find(:all, :conditions => { :srpm_id => @srpm.id})
    if @srpm == nil
      render :action => "nosuchpackage"
    end
  end

  def rawspec
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @branch = Branch.find :first, :conditions => { :urlname => params[:branch] }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch => @branch.urlname }
    if @srpm == nil
      render :action => "nosuchpackage"
    end
  end

  def patches
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @branch = Branch.find :first, :conditions => { :urlname => params[:branch] }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch => @branch.urlname }
    if @srpm == nil
      render :action => "nosuchpackage"
    end
  end

  def sources
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @branch = Branch.find :first, :conditions => { :urlname => params[:branch] }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch => @branch.urlname }
    if @srpm == nil
      render :action => "nosuchpackage"
    end
  end

  def download
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @branch = Branch.find :first, :conditions => { :urlname => params[:branch] }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch => @branch.urlname }
    if @srpm != nil
      @i586 = Package.find :all,
                           :conditions => {
                             :branch_id => @branch.id,
                             :sourcepackage => @srpm.filename,
                             :arch => 'i586' },
                           :order => 'name ASC'
      @noarch = Package.find :all,
                             :conditions => {
                               :branch_id => @branch.id,
                               :sourcepackage => @srpm.filename,
                               :arch => 'noarch' },
                             :order => 'name ASC'
      @x86_64 = Package.find :all,
                             :conditions => {
                               :branch_id => @branch.id,
                               :sourcepackage => @srpm.filename,
                               :arch => 'x86_64' },
                             :order => 'name ASC'
    else
      render :action => "nosuchpackage"
    end
  end

  def gear
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @branch = Branch.find :first, :conditions => { :urlname => params[:branch] }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch => @branch.urlname }
    if @srpm != nil
      @gitrepos = Gitrepos.find :all,
                                :conditions => { :package => @srpm.name },
                                :order => 'lastchange DESC'
    else
      render :action => "nosuchpackage"
    end
  end

  def bugs
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @branch = Branch.find :first, :conditions => { :urlname => params[:branch] }
    @bugs = Bug.find :all,
                     :conditions => {
                       :component => params[:name],
                       :product => params[:branch],
                       :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]},
                     :order => "bug_id DESC"

    @allbugs = Bug.find :all,
                        :conditions => {
                          :component => params[:name],
                          :product => params[:branch] },
                        :order => "bug_id DESC"
  end

  def allbugs
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @branch = Branch.find :first, :conditions => { :urlname => params[:branch] }
    @bugs = Bug.find :all,
                     :conditions => {
                       :component => params[:name],
                       :product => params[:branch],
                       :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]},
                     :order => "bug_id DESC"

    @allbugs = Bug.find :all,
                        :conditions => {
                          :component => params[:name],
                          :product => params[:branch] },
                        :order => "bug_id DESC"
  end

  def repocop
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @branch = Branch.find :first, :conditions => { :urlname => params[:branch] }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch => @branch.urlname }

    @repocops = Repocop.find :all,
                             :conditions => {
                               :srcname => @srpm.name,
                               :srcversion => @srpm.version,
                               :srcrel => @srpm.release }

    if @srpm == nil
      render :action => "nosuchpackage"
    end
  end

  def nosuchpackage
  end
end
