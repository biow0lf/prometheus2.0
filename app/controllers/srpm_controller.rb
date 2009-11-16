class SrpmController < ApplicationController
  layout "default"

  caches_page :main, :changelog, :rawspec, :patches, :sources, :download, :gear, :bugs, :allbugs, :repocop

  def main
    @sisyphus = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    @branch = Branch.find :first, :conditions => { :urlname => params[:branch] }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch_id => @branch.id }

    if @srpm != nil
      @allsrpms = Srpm.find :all,
                            :conditions => { :name => params[:name] }
#                            :order => 'branch ASC'

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
      end
    else
      render :action => "nosuchpackage"
    end
  end

  def changelog
    @sisyphus = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    @branch = Branch.find :first, :conditions => { :urlname => params[:branch] }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch_id => @branch.id }
    #@changelogs = Changelog.find(:all, :conditions => { :srpm_id => @srpm.id})
    if @srpm == nil
      render :action => "nosuchpackage"
    end
  end

  def rawspec
    @sisyphus = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    @branch = Branch.find :first, :conditions => { :urlname => params[:branch] }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch_id => @branch.id }
    if @srpm == nil
      render :action => "nosuchpackage"
    end
  end

  def patches
    @sisyphus = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    @branch = Branch.find :first, :conditions => { :urlname => params[:branch] }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch_id => @branch.id }
    if @srpm == nil
      render :action => "nosuchpackage"
    end
  end

  def sources
    @sisyphus = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    @branch = Branch.find :first, :conditions => { :urlname => params[:branch] }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch_id => @branch.id }
    if @srpm == nil
      render :action => "nosuchpackage"
    end
  end

  def download
    @sisyphus = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    @branch = Branch.find :first, :conditions => { :urlname => params[:branch] }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch_id => @branch.id }
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
    @sisyphus = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    @branch = Branch.find :first, :conditions => { :urlname => params[:branch] }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch_id => @branch.id }
    if @srpm != nil
      @gitrepos = Gitrepos.find :all,
                                :conditions => { :package => @srpm.name },
                                :order => 'lastchange DESC'
    else
      render :action => "nosuchpackage"
    end
  end

  def bugs
    @sisyphus = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
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
    @sisyphus = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
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
    @sisyphus = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    @branch = Branch.find :first, :conditions => { :urlname => params[:branch] }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch_id => @branch.id }
    if @srpm == nil
      render :action => "nosuchpackage"
    end
  end

  def nosuchpackage
  end
end
